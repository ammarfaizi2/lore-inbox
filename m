Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbRFRAHW>; Sun, 17 Jun 2001 20:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbRFRAHM>; Sun, 17 Jun 2001 20:07:12 -0400
Received: from imladris.infradead.org ([194.205.184.45]:34828 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S263167AbRFRAHB>;
	Sun, 17 Jun 2001 20:07:01 -0400
Date: Mon, 18 Jun 2001 01:06:54 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Ivan Vadovic <pivo@pobox.sk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: any good diff merging utility?
In-Reply-To: <20010618014547.B1063@ivan.doma>
Message-ID: <Pine.LNX.4.33.0106180102520.25038-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan.

 > I like to build kernels with a bunch of patches on top to test
 > new stuff. The problem is that it takes a lot of effort to fix
 > all the failed hunks during patching that really wouldn't have
 > to be failed if only patch was a little more inteligent and
 > could merge several patches into one ( if possible) or if could
 > take into account already applied patches.

The basic problem here is that the "failed hunks" are usually there
because of conflicts between the two patches in question, and as a
result, they are not as easy to merge automagically as one might at
first assume.

 > Well, are there any utilities to merge diffs? I couldn't find
 > any on freshmeat. So what are you using to stack many patches
 > onto the kernel tree? Just manualy modify the diff? I'll try to
 > write something more automatic if nothing comes up.

I once came across a utility called "diff3" that was designed to take
a patch for one version of a package and create an equivalent patch
for another version of the same package, but I haven't been able to
find it again since my hard drive crashed.

Best wishes from Riley.

