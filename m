Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267863AbRGRMMl>; Wed, 18 Jul 2001 08:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267864AbRGRMMb>; Wed, 18 Jul 2001 08:12:31 -0400
Received: from [212.17.205.82] ([212.17.205.82]:33275 "EHLO mbox.reitek.com")
	by vger.kernel.org with ESMTP id <S267863AbRGRMMU>;
	Wed, 18 Jul 2001 08:12:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fabrizio Ammollo <f.ammollo@reitek.com>
Organization: Reitek S.p.A.
To: Hans Reiser <reiser@namesys.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: PROBLEM: mount/umount blocked
Date: Wed, 18 Jul 2001 14:12:57 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01071809031300.01307@f-ammollo.reitek.com> <3B555AD2.B41EEC56@namesys.com>
In-Reply-To: <3B555AD2.B41EEC56@namesys.com>
MIME-Version: 1.0
Message-Id: <01071814125700.01306@f-ammollo.reitek.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 July 2001 11:45, Hans Reiser wrote:

>> Is it reiserfs or ext2 that fails to umount/mount?  Do I understand
>> correctly that is09660 also fails to mount/umount?

>The real question is what got blocked first. Mounting/unmounting is
>serialized, so any new mount/umount will simply wait for that one
>to complete.

What blocked first was the mount of the CDROM, so because they are serialized 
I understand now why all the sunsequent mounts failed too.. :-( 

It's a mystery to me, but right now I tried the following:

- mounting and unmounting an ext2 partition
- mounting and unmounting a vfat partition
- mounting and unmounting the CDROM

and all of them worked !!!

Absolutely *nothing* has changed in my machine's setup, except I rebooted it 
, but I already did it *many* times yesterday, so I don't know what to say. 
Maybe a temporary hardware problem ???  :-((( 

I thank both of  you for your interest  !

--
Regards,
Fabrizio
