Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280524AbRKXXdA>; Sat, 24 Nov 2001 18:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280510AbRKXXcu>; Sat, 24 Nov 2001 18:32:50 -0500
Received: from mail1.home.nl ([213.51.129.225]:19335 "EHLO mail1.home.nl")
	by vger.kernel.org with ESMTP id <S280494AbRKXXcf>;
	Sat, 24 Nov 2001 18:32:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: "F.H. Bulthuis" <bulthuis@home.nl>
Reply-To: bulthuis@home.nl
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.16-pre1
Date: Sun, 25 Nov 2001 00:32:35 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011124233234.PTJT16304.mail1.home.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 November 2001 19:39, Marcelo Tosatti wrote:
> Hi,
>
> So here it goes 2.4.16-pre1. Obviously the most important fix is the
> iput() one, which probably fixes the filesystem corruption problem people
> have been seeing.
>
> Please, people who have been experiencing the fs corruption problems test
> this and tell me its now working so I can release a final 2.4.16 ASAP.
>
>
> - Correctly sync inodes in iput()			(Alexander Viro)
> - Make pagecache readahead size tunable via /proc	(was in -ac tree)
> - Fix PPC kernel compilation problems			(Paul Mackerras)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hi,
After compiling and installing the new 2.4.16-pre1 uname -a reports here 
version 2.4.15-greased-turkey, not 2.4.16-pre1. 
bash-2.05$ uname -a
Linux nert 2.4.15-greased-turkey #1 Sat Nov 24 23:48:07 CET 2001 i686 unknown

Cheers,

Fred Bulthuis
n00b to this list :)
