Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbRGOQce>; Sun, 15 Jul 2001 12:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266684AbRGOQcX>; Sun, 15 Jul 2001 12:32:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25107 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266682AbRGOQcN>; Sun, 15 Jul 2001 12:32:13 -0400
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
To: volodya@mindspring.com
Date: Sun, 15 Jul 2001 17:33:11 +0100 (BST)
Cc: ajschrotenboer@lycosmail.com (Adam Schrotenboer),
        linux-kernel@vger.kernel.org (lkml), reiser@namesys.com
In-Reply-To: <Pine.LNX.4.20.0107151158360.645-100000@node2.localnet.net> from "volodya@mindspring.com" at Jul 15, 2001 12:00:14 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LopT-0004Cm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which is a good point - can ext2 handle more than 4gig partitions ? I have
> some vague ideas that it doesn't (and that it does not handle files more
> than 2gig long). I am reasonable sure that ReiserFS is better in this
> regard though I am not certain about this either.

Ext2 handles files larger than 2Gb, and can handle up to about 1Tb per volume
which is the block layer fs size limit.

Alan

