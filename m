Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266997AbUBRXOu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266977AbUBRXOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:14:49 -0500
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:18308 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S266997AbUBRXNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:13:47 -0500
From: Rusty Russell <rusty@au1.ibm.com>
To: Linda Xie <lxiep@ltcfwd.linux.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, gregkh@us.ibm.com,
       Mike Wortman <wortman@us.ibm.com>
Subject: Re: [PATCH] PPC64 PCI Hotplug Driver for RPA 
In-reply-to: Your message of "Wed, 18 Feb 2004 13:14:11 MDT."
             <4033B983.6060809@ltcfwd.linux.ibm.com> 
Date: Thu, 19 Feb 2004 09:27:18 +1100
Message-Id: <20040218231322.65F7C17DD8@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <4033B983.6060809@ltcfwd.linux.ibm.com> you write:
> >Umm, what's this?  Checking CONFIG_FOO_MODULE is basically always wrong
> >and especially in this case.  Just use "rpaphp" always.
> >  
> >
> Replaced with
> 
> #define MY_NAME "rpaphp"

Or better, remove #define and use KBUILD_MODNAME, which for this file
will be rpaphp anyway.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
