Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279106AbRKDWKE>; Sun, 4 Nov 2001 17:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279166AbRKDWJ4>; Sun, 4 Nov 2001 17:09:56 -0500
Received: from borderworlds.dk ([193.162.142.101]:33807 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S279106AbRKDWJp>; Sun, 4 Nov 2001 17:09:45 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2 directory index, updated
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org>
From: Christian Laursen <xi@borderworlds.dk>
Date: 04 Nov 2001 23:09:41 +0100
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org>
Message-ID: <m3hesatcgq.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> ***N.B.: still for use on test partitions only.***

It's the first time, I've tried this patch and I must say, that
the first impression is very good indeed.

I took a real world directory (my linux-kernel MH folder containing
roughly 115000 files) and did a 'du -s' on it.

Without the patch it took a little more than 20 minutes to complete.

With the patch, it took less than 20 seconds. (And that was inside uml)


However, when I accidentally killed the uml, it left me with an unclean
filesystem which fsck refuses to touch because it has unsupported features.

Even the latest version does this.

Is there a patch for fsck, that fixes this somewhere?

-- 
Best regards
    Christian Laursen
