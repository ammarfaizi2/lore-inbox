Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVGHPg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVGHPg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 11:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVGHPg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 11:36:58 -0400
Received: from ozlabs.org ([203.10.76.45]:12180 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262690AbVGHPgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 11:36:05 -0400
Subject: Re: device_find broken in 2.6.11?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050708042922.GA4603@kroah.com>
References: <1120796213.12218.55.camel@localhost.localdomain>
	 <20050708042922.GA4603@kroah.com>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 01:36:04 +1000
Message-Id: <1120836964.12218.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 21:29 -0700, Greg KH wrote:
> On Fri, Jul 08, 2005 at 02:16:53PM +1000, Rusty Russell wrote:
> > 
> > 	I was getting oopses in kset_find_obj when calling device_find in
> > 2.6.11.12.
> 
> Yup, there's a reason no one uses it.  Use the version in 2.6.13-rc2, it
> actually works.
> 
> What are you wanting to use it for?

The xenbus code wants to find if a device is new: the Xen code is
currently against on 2.6.11.12.

Thanks!
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

