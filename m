Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131177AbRCGXXK>; Wed, 7 Mar 2001 18:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131186AbRCGXW7>; Wed, 7 Mar 2001 18:22:59 -0500
Received: from austin.jhcloos.com ([206.224.83.202]:14342 "HELO
	austin.jhcloos.com") by vger.kernel.org with SMTP
	id <S131177AbRCGXWs>; Wed, 7 Mar 2001 18:22:48 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another?
In-Reply-To: <Pine.GSO.4.21.0103070402160.2127-100000@weyl.math.psu.edu>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Pine.GSO.4.21.0103070402160.2127-100000@weyl.math.psu.edu> (Alexander Viro's message of "Wed, 7 Mar 2001 04:09:31 -0500 (EST)")
Date: 07 Mar 2001 17:22:31 -0600
Message-ID: <m3u255411k.fsf@austin.jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AV" == Alexander Viro <viro@math.psu.edu> writes:

AV> Double ugh. Why bother with ioctl() when you can just have a
AV> second channel and do read()/write() on it?

Because you cannot rewrite -- or even re-compile -- every app this
should support.  OSS emulation by ALSA is a great example, given
how many binary-only apps already exist which need OSS emulation
on an ALSA box.

I'm sure sound is not the only real application for this.

-JimC
-- 
James H. Cloos, Jr.  <http://jhcloos.com/public_key>     1024D/ED7DAEA6 
<cloos@jhcloos.com>  E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
