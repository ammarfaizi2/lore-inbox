Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264450AbUEVCW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUEVCW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUEUWjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:39:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:32955 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265110AbUEUWdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:55 -0400
Date: Thu, 20 May 2004 21:31:14 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-ID: <20040521043114.GB31113@kroah.com>
References: <40AD3A88.2000002@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AD3A88.2000002@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 07:08:56PM -0400, nardelli wrote:
> Here is a proposed patch for Oops on disconnect in the visor module.
> For details of the problem, please see
> http://bugzilla.kernel.org/show_bug.cgi?id=2289
> 
> I would really appreciate it if anyone that uses this module could please
> try this patch to make sure that it works as intended.  Also, as this is
> the first patch that I've submitted, please feel free to be brutally
> honest regarding content, formatting, etc.

Oops, one other thing, you should CC: the driver author/maintainer too,
so they know what you are trying to do.  Don't assume they will see your
patch on a mailing list :)

thanks,

greg k-h
