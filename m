Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266781AbRGOSAx>; Sun, 15 Jul 2001 14:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266757AbRGOSAn>; Sun, 15 Jul 2001 14:00:43 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:26639 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S266754AbRGOSAf>; Sun, 15 Jul 2001 14:00:35 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Date: Sun, 15 Jul 2001 19:58:49 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9islo5$na2$1@ncc1701.cistron.net>
In-Reply-To: <E15LopT-0004Cm-00@the-village.bc.nu> <3B51C864.C98B61DE@namesys.com>
X-Trace: ncc1701.cistron.net 995220037 23874 213.46.44.164 (15 Jul 2001 18:00:37 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Hans Reiser" <reiser@namesys.com> wrote in message
news:cistron.3B51C864.C98B61DE@namesys.com...
>
> The limits for reiserfs and ext2 for kernels 2.4.x are the same (and they
are 2Tb not 1Tb).  The
> limits are not in the individual filesystems.  We need to have Linux go to
64 bit blocknumbers in
> 2.5.x, I am seeing a lot of customer demand for it.  (Or we could use
scalable integers, which would
> be better.)
>
> Hans
> -

It appears to be 1TB. Just last week I tried a 1.1TB fibre RAID array, and
found several signed/unsigned issues. Fdisk was unable to work with the
array. This on Slackware 8.0 distribution with 2.4.6 kernel.

Rob




