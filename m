Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbTIPMNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTIPMNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:13:11 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:6 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261834AbTIPMNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:13:08 -0400
Date: Tue, 16 Sep 2003 14:10:41 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Wade <neroz@ii.net>
Cc: David Yu Chen <dychen@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030916141041.B1561@pclin040.win.tue.nl>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <3F66CDB6.7000601@ii.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F66CDB6.7000601@ii.net>; from neroz@ii.net on Tue, Sep 16, 2003 at 04:45:42PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 04:45:42PM +0800, Wade wrote:

> Is the attached correct?

No, it frees memory that is still in use, and will oops the kernel.

> --- linux-2.6.0-test5.old/drivers/char/vt_ioctl.c	2003-08-23 07:57:57.000000000 +0800

There was no bug to start with, so please do not fix anything.

