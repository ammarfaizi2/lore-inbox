Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbUCLVtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbUCLVtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:49:41 -0500
Received: from 162.100.172.209.cust.nextweb.net ([209.172.100.162]:32977 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S262992AbUCLVtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 16:49:40 -0500
Mime-Version: 1.0
Message-Id: <p0610032fbc77de2c9c28@[192.168.0.3]>
In-Reply-To: <m13c8ef11b.fsf@ebiederm.dsl.xmission.com>
References: <40511868.4060109@usa.net>
 <m17jxqf2xf.fsf@ebiederm.dsl.xmission.com>	<4051EB42.8060903@pobox.com>
 <m13c8ef11b.fsf@ebiederm.dsl.xmission.com>
Date: Fri, 12 Mar 2004 13:48:54 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:06 AM -0700 3/12/04, Eric W. Biederman wrote:
>My intent was to say:  Why change the types when there is no #ifdef
>__KERNEL__ in the header.  With no #ifdef __KERNEL__ it exports
>definitions that are private to the kernel making it not safe for
>userspace to use.  With kernel private definitions in there it will
>generate name space pollution if included by user space.

Presumably because it *is* included by userspace, because it defines 
the interface between the kernel and userspace; of course userspace 
will (does) include it.

-- 
/Jonathan Lundell.
