Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288996AbSBDVsX>; Mon, 4 Feb 2002 16:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289056AbSBDVsO>; Mon, 4 Feb 2002 16:48:14 -0500
Received: from [195.163.186.27] ([195.163.186.27]:4820 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S288996AbSBDVsA>;
	Mon, 4 Feb 2002 16:48:00 -0500
Date: Mon, 4 Feb 2002 23:47:51 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: David Balazic <david.balazic@uni-mb.si>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020204234751.U5808@mea-ext.zmailer.org>
In-Reply-To: <3C5EB063.D6C18692@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5EB063.D6C18692@uni-mb.si>; from david.balazic@uni-mb.si on Mon, Feb 04, 2002 at 05:01:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 05:01:39PM +0100, David Balazic wrote:
> Hi!
> 
> This problem again :-)
> 
> I purchase/download a program for linux.
> It says it requires certain kernel features, for example :
> CONFIG_PROC_FS,CONFIG_NET,CONFIG_INET

   If it wants THOSE, it is asking for wrong abstraction layer 
   information.

   No userspace program (beside of special sysadmin tools) should
   be poking into PROC_FS.  The NET interface abstraction is already
   wrapped inside  libc.

> How can I figure out in 5 minutes, without a kernel hacker, if
> my linux system has the correct settings ?

   Good software gives clear diagnostics if some necessary facility
   is missing at runtime.

> This is a real life question, probably more suitable to ask
> on some distributions mail list, but I thought I'll start here.
> 
> TIA,
> david
> -- 
> David Balazic

/Matti Aarnio
