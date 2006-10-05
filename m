Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWJEVwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWJEVwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWJEVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:52:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932306AbWJEVwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:52:34 -0400
Date: Thu, 5 Oct 2006 14:52:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       tim.c.chen@linux.intel.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-Id: <20061005145213.f3eaaf7d.akpm@osdl.org>
In-Reply-To: <45257C65.3030600@goop.org>
References: <B41635854730A14CA71C92B36EC22AAC3F3FBA@mssmsx411>
	<20061005143748.2f6594a2.akpm@osdl.org>
	<45257C65.3030600@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 14:43:01 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > So how's this look?
> >   
> 
> Looks fine to me.  Other than the general question of why WARN_ON* 
> returns a value at all, and if so, does the final unlikely() really do 
> anything.

Herbert had a good-sounding reason for wanting this feature, but afaict he
hasn't proceeded to use it at this stage.  And he's hiding from us ;)
