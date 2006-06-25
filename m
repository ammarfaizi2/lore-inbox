Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWFYKJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWFYKJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWFYKJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:09:28 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:15834 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751225AbWFYKJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:09:27 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Date: Sun, 25 Jun 2006 12:09:23 +0200
User-Agent: KMail/1.9.1
Cc: "Nathan Scott" <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com> <20060620165209.C1080488@wobbly.melbourne.sgi.com> <3aa654a40606200120v5baf0304ka205f1ad8f136ad9@mail.gmail.com>
In-Reply-To: <3aa654a40606200120v5baf0304ka205f1ad8f136ad9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606251209.23766.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a new XFS crash running 2.6.17, again with problems at block
16777216 - I'll try to make a copy of the corrupted filesystem available.
Interestingly enough, I'm also seeing ext3 corruption.  The usual
manifestation is that a program fails to run, with a message about it
not being in executable format (if it happens again I will take a note of
the exact message).  I've had no problems at all with 2.6.17.  It seems
to be happening randomly, which makes me suspect a race condition
(uniprocessor machine, but preemptable kernel), or memory corruption.
I will rebuild the kernel with all kernel debugging options turned
on, once I recover the filesystem.

Ciao,

D.
