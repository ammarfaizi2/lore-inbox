Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbTLGDLj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 22:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbTLGDLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 22:11:39 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:50110 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S265294AbTLGDLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 22:11:38 -0500
Date: Sat, 6 Dec 2003 22:09:44 -0500 (EST)
From: Mike Gorse <mgorse@mgorse.dhs.org>
To: Greg KH <greg@kroah.com>
cc: Maneesh Soni <maneesh@in.ibm.com>, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: Oops w/sysfs when closing a disconnected usb serial device
In-Reply-To: <20031207025859.GA28787@kroah.com>
Message-ID: <Pine.LNX.4.58.0312062205180.2141@mgorse.dhs.org>
References: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org>
 <20031201093804.GA6918@in.ibm.com> <Pine.LNX.4.58.0312011849050.9617@mgorse.dhs.org>
 <20031206013844.GA16844@kroah.com> <Pine.LNX.4.58.0312052102460.13792@mgorse.dhs.org>
 <20031207025859.GA28787@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003, Greg KH wrote:

> Hm, wait.  I mean use your sysfs patch, _and_ my patch.  Previously you
> had said your sysfs patch had only moved the oops elsewhere.  I found
> that true myself, hence my patch.  With both patches, things work for
> me, how about you?
> 
The sysfs patch has always eliminated my oops; applying the kobject patch 
that Maneesh created without the sysfs patch moved the oops elsewhere.

-Mike G-
