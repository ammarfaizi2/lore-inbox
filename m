Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSGQToM>; Wed, 17 Jul 2002 15:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSGQToL>; Wed, 17 Jul 2002 15:44:11 -0400
Received: from ip68-6-153-107.sd.sd.cox.net ([68.6.153.107]:29531 "EHLO
	train.sweet-haven.com") by vger.kernel.org with ESMTP
	id <S316601AbSGQToL>; Wed, 17 Jul 2002 15:44:11 -0400
Date: Wed, 17 Jul 2002 12:47:04 -0700 (PDT)
From: Lew Wolfgang <wolfgang@sweet-haven.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks (whither dump?)
In-Reply-To: <ah4dpn$2tj$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33.0207171233050.25238-100000@train.sweet-haven.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

As an old dump user (dumpster?) I have to admit that we've
avoided ext3 and Reiserfs because of this issue.  We couldn't
live without the "Tower of Hanoi".

I remember using, many years ago (SunOS 3.4), a patched
dump binary that allowed safe dumps from live UFS filesystems.
I don't remember all the details (it was 16-years ago) but
this dump would compare somehow, files before and after writing
to tape.  If there was a difference it would back out the
dumped file and preserve the consistency of the tape.  I don't
remember if it would go back and try the file again.

I haven't the foggest notion if this would work in these
modern times, I'm just offering it as food for thought.

Regards,
Lew Wolfgang


