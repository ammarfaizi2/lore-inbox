Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129377AbRBHEHl>; Wed, 7 Feb 2001 23:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRBHEHb>; Wed, 7 Feb 2001 23:07:31 -0500
Received: from [216.29.39.226] ([216.29.39.226]:28678 "HELO
	mail.acetechnologies.net") by vger.kernel.org with SMTP
	id <S129377AbRBHEHU>; Wed, 7 Feb 2001 23:07:20 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs - problems mounting after power outage (FIXED)
Message-ID: <981605360.3a821bf01c01a@ns1.acetechnologies.net>
Date: Wed, 07 Feb 2001 23:09:20 -0500 (EST)
From: Jeff McWilliams <Jeff.McWilliams@acetechnologies.net>
Cc: Jeff McWilliams <Jeff.McWilliams@acetechnologies.net>,
        Chris Mason <mason@suse.com>
In-Reply-To: <Pine.LNX.4.10.10102071838230.6344-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10102071838230.6344-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 24.22.75.92
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved.  I downloaded the latest reiserfs_utils 3.6.25 from
namesys.com and built and ran reiserfsck against the partition with the
--rebuild-tree option.  It completed successfully and I was able to mount
the partition without any further problems.

I'll build and install a 2.4.1 kernel sometime tomorrow and get it running on
that machine to address any further issues.

many thanks for the tips & suggestions

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
