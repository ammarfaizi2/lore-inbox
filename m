Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUBDMgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 07:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUBDMgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 07:36:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21124 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261152AbUBDMgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 07:36:45 -0500
Date: Wed, 4 Feb 2004 07:38:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Gaspar Bakos <gbakos@cfa.harvard.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: change kernel name
In-Reply-To: <Pine.SOL.4.58.0402031832060.1195@antu.cfa.harvard.edu>
Message-ID: <Pine.LNX.4.53.0402040735040.3999@chaos>
References: <Pine.SOL.4.58.0402031832060.1195@antu.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Gaspar Bakos wrote:

> Hello,
>
> I have the following question:
> If I compile the kernel (2.4.*) and boot it in, then the kernel-release,
> as shown by 'uname -r' will be the string that was in the EXTRAVERSION
> string from the kernel Makefile.
> Is there any way to change this 'identity' of the kernel after the
> compilation?
> Such as
> changekernelname bzImage "newname"

Put anything you want in the structure, system_utsname, in your copy of
linux-nn-nn/init/version.c.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


