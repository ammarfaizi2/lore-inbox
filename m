Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284906AbRLPXO1>; Sun, 16 Dec 2001 18:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284908AbRLPXOH>; Sun, 16 Dec 2001 18:14:07 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:63418
	"HELO tabris.net") by vger.kernel.org with SMTP id <S284906AbRLPXOA>;
	Sun, 16 Dec 2001 18:14:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <adam@tabris.net>
Organization: Dome-S-Isle Data
To: Robert Love <rml@tech9.net>,
        =?iso-8859-1?q?Ra=FAlN=FA=F1ez=20de=20Arenas=20Coronado?= 
	<raul@viadomus.com>
Subject: Re: Is /dev/shm needed?
Date: Sun, 16 Dec 2001 18:13:58 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16FjME-0000WW-00@DervishD.viadomus.com> <1008541849.11242.2.camel@phantasy>
In-Reply-To: <1008541849.11242.2.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011216231358.99830FB80D@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 December 2001 17:30, Robert Love wrote:
> In other words, if you have memory to spare and the data ought to be
> cached, Linux probably will cache it anyhow.  On the other hand, if you
> have lots of memory to spare, give it a try.  Mount /tmp or all of /var
> in tmpfs.

Unfortunately, some(many?) distros are b0rken in re /var/. There is stuff put 
there that is needed across boots (for example, mandrake puts the DNS master 
files in /var/named.)

>
> It is dynamic, so you don't need to specify a size.  If you want to give
> a maximum size (probably a good idea), give one.  Depends on what your
> tmp usages are and how much free memory you have.
>
> 	Robert Love

-- 
tabris

   Sweet is love when all is sane
   Sweet is death to rid the pain
   Cruel is death when all is well
   Cruel is love when all is hell

                                                            Author unkown

