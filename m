Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129427AbRBSLYw>; Mon, 19 Feb 2001 06:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbRBSLYl>; Mon, 19 Feb 2001 06:24:41 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15888 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129427AbRBSLYZ>; Mon, 19 Feb 2001 06:24:25 -0500
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Mon, 19 Feb 2001 11:23:56 +0000 (GMT)
Cc: dek_ml@konerding.com, neilb@cse.unsw.edu.au (Neil Brown),
        linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <14992.38288.497367.324493@notabene.cse.unsw.edu.au> from "Neil Brown" at Feb 19, 2001 02:40:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UoQA-0003BM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I hope to put out a patch set for testing in a day or so and possibly
> suggest it to Alan for his -ac series.  I don't see it going into
> 2.4.2, but 2.4.3 might be possible if Linus agrees.

Im not interested in a patch that requires NFS is hacked for each file system
that tells me the implementation is wrong. The previous setup worked perfectly
for everything but reiserfs, so why isnt the newer setup one allowing each fs
to override a generic behaviour which is the current working behaviour, thereby
meaning all the other fs's work.

FS authors shouldnt have to do extra work to support knfsd unless they are doing
interesting and unusual things

