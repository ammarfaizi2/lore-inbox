Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313311AbSDJQgn>; Wed, 10 Apr 2002 12:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSDJQgm>; Wed, 10 Apr 2002 12:36:42 -0400
Received: from sendmail.avnet.com ([12.9.139.96]:5988 "EHLO pilsner.avnet.com")
	by vger.kernel.org with ESMTP id <S313311AbSDJQgm>;
	Wed, 10 Apr 2002 12:36:42 -0400
Message-ID: <C08678384BE7D311B4D70004ACA371050B7633A6@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Amol Kumar Lad'" <amolk@ishoni.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Reducing root filesystem
Date: Wed, 10 Apr 2002 09:36:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For my boards, I have about a 5 MB RAM disk, at least half of
which is libraries, much of which I know is library routines
which my embedded system never calls.  If I were tight on space,
here is where I would trim.

I don't know if you're doing PowerPC or some other processor,
but nonetheless you might check out 

http://penguinppc.org/embedded/howto/PowerPC-Embedded-HOWTO.html

and especially section 12:

http://penguinppc.org/embedded/howto/library.html

for some pointers to small C libraries.


-----Original Message-----
From: Amol Kumar Lad [mailto:amolk@ishoni.com]
Sent: Wednesday, April 10, 2002 7:08 AM
To: 'linux-kernel@vger.kernel.org'
Subject: Reducing root filesystem


Hi,
  I am porting Linux to an embedded system. Currently my rootfilesystem is
around 2.5 MB (after keeping it to minimal and adding tools like busybox). I
want to furthur reduce it to say maximum of 1.5 MB. 
Please suggest some link/references where I can find the details to optimise
my root filesystem

thanks
Amol

please CC me
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
