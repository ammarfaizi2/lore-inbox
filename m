Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282010AbRKVBzB>; Wed, 21 Nov 2001 20:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282011AbRKVByw>; Wed, 21 Nov 2001 20:54:52 -0500
Received: from cogito.cam.org ([198.168.100.2]:32273 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S282010AbRKVBym>;
	Wed, 21 Nov 2001 20:54:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andreas Dilger <adilger@turbolabs.com>,
        Nikita Danilov <Nikita@namesys.com>
Subject: Re: [reiserfs-list] Re: [REISERFS TESTING] new patches on ftp.namesys.com: 2.4.15-pre7
Date: Wed, 21 Nov 2001 07:58:28 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111210110.fAL1Atc11275@beta.namesys.com> <15355.27299.252362.983624@beta.reiserfs.com> <20011121011655.M1308@lynx.no>
In-Reply-To: <20011121011655.M1308@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011121125829.345E89C77@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 21, 2001 03:16 am, Andreas Dilger wrote:

> In any case, it is also a bad thing to leave garbage in unused parts of
> on-disk data structs for just this reason, so mkreiserfs should zero
> everything that is unused inside allocated structs (and the kernel too,
> because reiserfs allocates inode tables dynamically, right?).

Also reiserfsck?  It would be nice if it cleaned too...

Ed Tomlinson
