Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUGLRN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUGLRN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUGLRN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:13:28 -0400
Received: from hera.kernel.org ([63.209.29.2]:34511 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266891AbUGLRN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:13:26 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: question about ramdisk
Date: Mon, 12 Jul 2004 17:13:02 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ccugqu$tun$1@terminus.zytor.com>
References: <1089651469.40f2c30d44364@core.ece.northwestern.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1089652382 30680 127.0.0.1 (12 Jul 2004 17:13:02 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 12 Jul 2004 17:13:02 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1089651469.40f2c30d44364@core.ece.northwestern.edu>
By author:    lya755@ece.northwestern.edu
In newsgroup: linux.dev.kernel
>
> Hi all,
> 
> I am learning linux kernel and have a question about ramdisk. When loading an 
> executable in ramdisk, is the kernel loading the code all at a time to memory 
> and then execute, or is it loading only a page at one time and generating a 
> page fault to fetch another page?
> 
> Thanks for any comments! Waiting desprately for your help.
> 

Neither.  The code is already in RAM.  It's mapped into the process
address space and run in place.

	-hpa
