Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVDFI0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVDFI0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVDFI0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:26:34 -0400
Received: from mail.bencastricum.nl ([213.84.203.196]:47632 "EHLO
	bencastricum.nl") by vger.kernel.org with ESMTP id S262033AbVDFI0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:26:32 -0400
Date: Wed, 6 Apr 2005 10:22:50 +0200 (CEST)
From: Ben Castricum <benc@bencastricum.nl>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2 compile error in drivers/usb/class/cdc-acm.c
In-Reply-To: <20050406001807.GB7226@stusta.de>
Message-ID: <Pine.LNX.4.58.0504061012420.31870@gateway.bencastricum.nl>
References: <Pine.LNX.4.58.0504051026330.30674@gateway.bencastricum.nl>
 <20050406001807.GB7226@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-bencastricum-MailScanner-Information: Please contact the ISP for more information
X-bencastricum-MailScanner: Found to be clean
X-MailScanner-From: benc@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Apr 2005, Adrian Bunk wrote:

> On Tue, Apr 05, 2005 at 10:54:09AM +0200, Ben Castricum wrote:
> > ...
> >   CC      fs/quota_v2.o
> > fs/quota_v2.c: In function `v2_write_dquot':
> > fs/quota_v2.c:399: warning: unknown conversion type character `z' in
> > format
> > fs/quota_v2.c:399: warning: too many arguments for format
>
> These are warnings that only occur with gcc 2.95 and that can safely be
> ignored.

Just wondering, isn't 2.95.3 the recommended compiler anymore? I only use
this (a bit old) version because it's _the_ compiler for the kernel.

If it still is then I find it a bit strange that code is accepted that
doesn't compile cleanly on the recommended compiler.

Thanks for your help,
Ben
