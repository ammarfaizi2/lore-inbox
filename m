Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSJIXFB>; Wed, 9 Oct 2002 19:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSJIXFB>; Wed, 9 Oct 2002 19:05:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36876 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262913AbSJIXFA>; Wed, 9 Oct 2002 19:05:00 -0400
Date: Wed, 9 Oct 2002 16:12:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tim Hockin <thockin@hockin.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
In-Reply-To: <200210092243.g99MhZ701270@www.hockin.org>
Message-ID: <Pine.LNX.4.44.0210091609570.9234-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Tim Hockin wrote:
> 
> Renaming it, if that is all you want, is fine by everyone, I'm sure.  I was
> trying to make the point that it is NOT a config option, because for some
> architectures, you only want it defined for SOME FILES.

No. I'm not going to accept crap like that.

It's either defined or not.  None of the "only sometimes".

Make a CONFIG_xxx option that means what s390 wants it to mean, and no, 
I'm not going to accept it if you #define that by hand in some .c file. It 
needs to be in the architecture config file, like all the other config 
options.

		Linus

