Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264941AbUELClb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUELClb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 22:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbUELClb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 22:41:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23434 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264941AbUELCl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 22:41:29 -0400
Date: Tue, 11 May 2004 22:45:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Junfeng Yang <yjf@stanford.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU,
       madan@cs.Stanford.EDU, "David L. Dill" <dill@cs.Stanford.EDU>
Subject: Re: [CHECKER] e2fsck writes out blocks out of order, causing root
 dir to be corrupted (ext3, linux 2.4.19, e2fsprogs 1.34)
In-Reply-To: <Pine.GSO.4.44.0405111749290.2448-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.LNX.4.53.0405112238140.3269@chaos>
References: <Pine.GSO.4.44.0405111749290.2448-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Junfeng Yang wrote:

> Hi,
>
> We got a warning that the filesystem was in a inconsistent state when:
> 1. created a crashed disk image
> 2. ran fsck over the image and then crash fsck at certain point
> 3. re-ran fsck.

Question?  Is fsck specified to be able to be crashed? I'm not
sure you could ever make a repair-tool that could do that unless
there was some "guaranteed to save device" on an independent power
source during the repair. Fsck can't commit partial fixes of some
stuff because it would leave the file-system in an unrecoverable
state. It needs to complete.

Judging by the number of Stanford people being copied, I would
guess that this is a troll-probe?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


