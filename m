Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbRENQFJ>; Mon, 14 May 2001 12:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbRENQE7>; Mon, 14 May 2001 12:04:59 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33033 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262186AbRENQEx>; Mon, 14 May 2001 12:04:53 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Re: Inodes]
Date: 14 May 2001 09:04:46 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9dovmu$eqj$1@cesium.transmeta.com>
In-Reply-To: <20010514073547.12678.qmail@nwcst284.netaddress.usa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010514073547.12678.qmail@nwcst284.netaddress.usa.net>
By author:    Blesson Paul <blessonpaul@usa.net>
In newsgroup: linux.dev.kernel
>
> Hi J
>                   You misunderstood my question. Let take an example.
> Let I have a msdos partition. No msdos files has inode numbers, right. Let I
> mount that msdos partition. Then what happens, That is my question. Will the
> inode numbers are assigned to all msdos files at mounting time itself
> 

The inode numbers are "invented" by the MS-DOS filesystem driver.  In
the particular case of the "msdos" driver I believe it uses the
location of the directory entry (the functional equivalent of the
inode) on disk.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
