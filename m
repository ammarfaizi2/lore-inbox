Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278690AbRLBNzf>; Sun, 2 Dec 2001 08:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282876AbRLBNzZ>; Sun, 2 Dec 2001 08:55:25 -0500
Received: from quechua.inka.de ([212.227.14.2]:23568 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S278690AbRLBNzV>;
	Sun, 2 Dec 2001 08:55:21 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: EXT3 - freeze ups during disk writes
In-Reply-To: <Pine.LNX.4.33.0112011209190.3893-100000@localhost.localdomain>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E16AX5E-0006pH-00@calista.inka.de>
Date: Sun, 02 Dec 2001 14:55:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0112011209190.3893-100000@localhost.localdomain> you wrote:
> And to 
> clarify the bug, say on a large disk write, the pause isn't constant,

You should elaborate more on the type of disks writes. Is this a write to a
single large file, a rename/delte of a large tree, ot generating of a lot of
files. Cause there is a difference in the meta data and data handling. both
where known to take too much time in different versions.

Greetings
Bernd
