Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266966AbTGTLkP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 07:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266987AbTGTLkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 07:40:15 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:47622 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266966AbTGTLkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 07:40:12 -0400
Subject: Re: [2.6.0-test1-mm2] unable to mount root fs on unknown-block(0,0)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Florian Huber <florian.huber@mnet-online.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030720125547.11466aa4.florian.huber@mnet-online.de>
References: <20030720125547.11466aa4.florian.huber@mnet-online.de>
Content-Type: text/plain
Message-Id: <1058702109.691.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Jul 2003 13:55:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-20 at 12:55, Florian Huber wrote:
> Hello ML,
> I can't boot my 2.6.0-test1-mm2 kernel (+GCC 3.3). The kernel panics
> at bootime:
> 
> VFS: Cannot open root device "hda3" or unknow-block(0,0)
> Please append a correct "root=" boot option
> Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> I do have compiled support for the file system on my root partition
> (xfs). The same configuration worked well with 2.6.0-test1-mm1.
> 
> Perhaps somebody knows how to solve this.

I've also seen this when trying to boot -mm2. Every configuration option
was left as it was in -mm1. Andrew, any ideas?

