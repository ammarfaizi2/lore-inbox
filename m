Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbUKSFEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUKSFEe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 00:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUKSFEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 00:04:34 -0500
Received: from hera.kernel.org ([63.209.29.2]:27339 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261240AbUKSFEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 00:04:31 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Kernel thoughts of a Linux user
Date: Fri, 19 Nov 2004 05:04:24 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cnjuso$ukp$1@terminus.zytor.com>
References: <200411181859.27722.gjwucherpfennig@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1100840664 31386 127.0.0.1 (19 Nov 2004 05:04:24 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 19 Nov 2004 05:04:24 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200411181859.27722.gjwucherpfennig@gmx.net>
By author:    "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
In newsgroup: linux.dev.kernel
>
> - setting up kernel boot parameters with graphical tools is unreliable, 
> because the system doesn't know which bootloader entry was chosen.
> One solution to this issue is to create a new kernel parameter "loaderhint"
> where the bootloader will be able to set the number of the chosen boot entry.
> In the configuration file of the bootloader this will have to be explicitly 
> remarked e.g. ... loaderhint=%selection% ... . Unfortunately this could be
> circumvented, because it isn't mandatory and could be manipulated in the boot 
> loader configuration. (Other/better suggestions are welcome)
> 

Most boot loaders have an BOOT_IMAGE option visible in /proc/cmdline.

	-hpa
