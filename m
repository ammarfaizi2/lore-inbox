Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWFYNzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWFYNzW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWFYNzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:55:22 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:12003 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750894AbWFYNzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:55:22 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Date: Sun, 25 Jun 2006 15:55:17 +0200
User-Agent: KMail/1.9.1
Cc: "Nathan Scott" <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com> <3aa654a40606200120v5baf0304ka205f1ad8f136ad9@mail.gmail.com> <200606251209.23766.duncan.sands@math.u-psud.fr>
In-Reply-To: <200606251209.23766.duncan.sands@math.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606251555.18356.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 June 2006 12:09, Duncan Sands wrote:
> I just got a new XFS crash running 2.6.17, again with problems at block
> 16777216 - I'll try to make a copy of the corrupted filesystem available.
> Interestingly enough, I'm also seeing ext3 corruption.  The usual
> manifestation is that a program fails to run, with a message about it
> not being in executable format (if it happens again I will take a note of
> the exact message).  I've had no problems at all with 2.6.17.  It seems
> to be happening randomly, which makes me suspect a race condition
> (uniprocessor machine, but preemptable kernel), or memory corruption.
> I will rebuild the kernel with all kernel debugging options turned
> on, once I recover the filesystem.

Sorry, that should say: "I've had no problems at all with 2.6.15".
Also, xfs_repair successfully repaired the filesystem this time.
I've kept a copy of the filesystem in case anyone is interested.

Duncan.
