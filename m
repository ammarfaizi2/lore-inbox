Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277152AbRJ3SK4>; Tue, 30 Oct 2001 13:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277253AbRJ3SKt>; Tue, 30 Oct 2001 13:10:49 -0500
Received: from lambik.cc.kuleuven.ac.be ([134.58.10.1]:15881 "EHLO
	lambik.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S277317AbRJ3SKl>; Tue, 30 Oct 2001 13:10:41 -0500
Message-Id: <200110301811.TAA17870@lambik.cc.kuleuven.ac.be>
Content-Type: text/plain; charset=US-ASCII
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
To: linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
Date: Tue, 30 Oct 2001 19:11:08 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.21.0110301557560.1229-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0110301557560.1229-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Op dinsdag 30 oktober 2001 17:07, schreef Hugh Dickins:
> I'm fairly sure /proc/slabinfo will show large inode_cache and large
> dentry_cache: which is natural after updatedb, nothing wrong with that.

indeed.

before updatedb:

inode_cache        10594  10605    512 1515 1515    1
dentry_cache       18239  18240    128  608  608    1

after:

inode_cache       220883 220913    512 31558 31559    1
dentry_cache      229471 229500    128 7650 7650    1

but i guess this comes a bit late :)

greetings,
frank
