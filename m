Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265081AbUELA2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUELA2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUELAZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:25:34 -0400
Received: from hera.kernel.org ([63.209.29.2]:42934 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263467AbUELAMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:12:46 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: From Eric Anholt:
Date: Wed, 12 May 2004 00:12:03 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c7rq4j$gjp$1@terminus.zytor.com>
References: <200405112211.i4BMBQDZ006167@hera.kernel.org> <Pine.LNX.4.58.0405120018360.3826@skynet> <200405112334.i4BNYdjO018918@turing-police.cc.vt.edu> <20040511234329.GA27242@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1084320723 17018 127.0.0.1 (12 May 2004 00:12:03 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 12 May 2004 00:12:03 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040511234329.GA27242@kroah.com>
By author:    Greg KH <greg@kroah.com>
In newsgroup: linux.dev.kernel
> 
> Don't know, but how are you dealing with the issue that an "int" is
> different for different kernel sizes (64 vs 32) and userspace too.
> That's why you can't use it in an ioctl and expect things to work
> properly.
> 

On Linux, "int" should always be 32 bits.  "long", and "void *",
however, may be 32 or 64 bits.

	-hpa
