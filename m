Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313044AbSDEQVP>; Fri, 5 Apr 2002 11:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313047AbSDEQVF>; Fri, 5 Apr 2002 11:21:05 -0500
Received: from web20503.mail.yahoo.com ([216.136.226.138]:38577 "HELO
	web20503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313044AbSDEQUx>; Fri, 5 Apr 2002 11:20:53 -0500
Message-ID: <20020405162050.36309.qmail@web20503.mail.yahoo.com>
Date: Fri, 5 Apr 2002 18:20:50 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: faster boots?
To: Bill Davidsen <davidsen@tmr.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020405101901.8337A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote : 

> There is a scsi-idle program of some age
> floating around, I haven't looked at that but
> I know it exists.

I have it on my server, and used it with the
associated patch for kernel 2.2. The problem
is not to spin the disk down, which is handled
in userspace, but to automatically spin it up
upon any access. Thus the patch. I have not
ported it to 2.4 because it wasn't trivial and
I didn't have time for it. But I may one day I
will be bored with my server's noise and I'll
do it. If you want to give it a try, you can
download it from one of my old 2.2 trees :

http://www-miaif.lip6.fr/willy/linux-patches/server-kernels/2.2.19-wt3/H-I9-2.2.19-wt3-wtstuff/scsi-idle-2.2.15.diff

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
