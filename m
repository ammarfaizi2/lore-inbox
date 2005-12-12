Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVLLUVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVLLUVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVLLUVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:21:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:18092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750800AbVLLUVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:21:15 -0500
Date: Mon, 12 Dec 2005 12:20:20 -0800
From: Greg KH <greg@kroah.com>
To: Richard Henderson <rth@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Ashutosh Naik <ashutosh.naik@gmail.com>,
       anandhkrishnan@yahoo.com, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Message-ID: <20051212202019.GA28131@kroah.com>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com> <20051212111322.40be4cfe.akpm@osdl.org> <20051212192746.GE19245@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212192746.GE19245@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 11:27:46AM -0800, Richard Henderson wrote:
> On Mon, Dec 12, 2005 at 11:13:22AM -0800, Andrew Morton wrote:
> > Do we really need to do this at runtime?
> 
> Probably.  One could consider this a security hole...

Huh?  You are root and loading a kernel module.  You can do much worse
things at this point in time than messing around with existing symbols
:)

I think it should be a build-time thing if possible.

thanks,

greg k-h
