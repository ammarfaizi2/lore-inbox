Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262439AbTCIGbZ>; Sun, 9 Mar 2003 01:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbTCIGbZ>; Sun, 9 Mar 2003 01:31:25 -0500
Received: from starcraft.mweb.co.za ([196.2.45.78]:11680 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id <S262439AbTCIGbY>; Sun, 9 Mar 2003 01:31:24 -0500
Date: Sun, 9 Mar 2003 08:36:33 +0200
From: Martin Schlemmer <azarah@gentoo.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Corruption problem with ext3 and htree
Message-Id: <20030309083633.5834d8fe.azarah@gentoo.org>
In-Reply-To: <20030308233219.G1373@schatzie.adilger.int>
References: <20030307063940.6d81780e.azarah@gentoo.org>
	<20030306234819.Q1373@schatzie.adilger.int>
	<20030309063345.47046254.azarah@gentoo.org>
	<20030308233219.G1373@schatzie.adilger.int>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Mar 2003 23:32:19 -0700
Andreas Dilger <adilger@clusterfs.com> wrote:

> Out of curiosity, when was the last time before this that the
> filesystem was fsck'd?  This sounds a lot like a problem that was (I
> think) fixed a couple of months ago relating to renaming files (search
> for "htree" in ext2-devel and/or linux-kernel archives around Nov 07,
> 2002).
> 

Well, several times already since I had this problem.  Cleared out some
stuff, fsck -c 'd it, etc.

If I move the portage's tmpdir to / which is ext3 without dir_index,
then it works just fine.


Regards,

-- 

Martin Schlemmer
