Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbTEMBtr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTEMBtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:49:06 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:40344 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S263132AbTEMBsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:48:11 -0400
Date: Mon, 12 May 2003 21:57:28 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200305122200_MC3-1-3890-B108@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoav Weiss wrote:

>>   "That can be done manually" does not get you the check mark in
>> the list of features.  Management wants idiot-resistant security.
>
> It has nothing to do with idiot-resistance.  Why should this multi-write
> operation be done in kernel ?  mkswap is a usermode program.  mkfs is a
> usermode program.  If you want to have a wipeswap script that copies a
> chunk of your /dev/zero to the swap, it should also be in usermode.  Just
> run it in wherever rc file you use to swapoff.

  And when I type 'swapoff' at the command line the whole scheme fails
unless I am a perfect robot sysadmin and always remember to wipe the
file.  This needs to 'fail safe' and it needs to be done within the kernel
to be considered a working feature.
