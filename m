Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135206AbRD3Tmm>; Mon, 30 Apr 2001 15:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135853AbRD3Tmd>; Mon, 30 Apr 2001 15:42:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:3085 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135206AbRD3TmP>; Mon, 30 Apr 2001 15:42:15 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: make bzlilo seems to ignore non-standard kernel path in lilo.conf (/boot)
Date: 30 Apr 2001 12:42:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ckf6a$4en$1@cesium.transmeta.com>
In-Reply-To: <01043012162401.00851@Seaborg> <12019.988632023@ocs3.ocs-net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <12019.988632023@ocs3.ocs-net>
By author:    Keith Owens <kaos@ocs.com.au>
In newsgroup: linux.dev.kernel
>
> On Mon, 30 Apr 2001 12:16:24 +0200, 
> Olaf Stetzer <ostetzer@mail.uni-mainz.de> wrote:
> >when I tried to get rid of the problem I wrote about two days ago in 
> >this list I compiled the kernel several times but unfortunately it was
> >not installed correctly by the make target bzlilo.
> 
> make INSTALL_PATH=/boot bzlilo
> 

Or better yet, set up /sbin/installkernel for your system and do "make
install".

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
