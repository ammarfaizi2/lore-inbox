Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbRBBWjL>; Fri, 2 Feb 2001 17:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130467AbRBBWjB>; Fri, 2 Feb 2001 17:39:01 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:61201 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S130397AbRBBWir>; Fri, 2 Feb 2001 17:38:47 -0500
Message-ID: <3A7B2F7C.52AA6AFA@namesys.com>
Date: Sat, 03 Feb 2001 01:06:52 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ion Badulescu <ionut@moisil.cs.columbia.edu>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink 
 related)
In-Reply-To: <E14OoD8-0007GI-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > As it stands, there is no way to determine programatically whether
> > gcc-2.96 is broken or now. The only way to do it is to check the RPM
> > version -- which, needless to say, is a bit difficult to do from the
> > C code about to be compiled. So I can't really blame Hans if he decides
> > to outlaw gcc-2.96[.0] for reiserfs compiles.
> 
> Oh I can see why Hans wants to cut down his bug reporting load. I can also
> say from experience it wont work. If you put #error in then everyone will
> mail him and complain it doesnt build, if you put #warning in nobody will
> read it and if you dont put anything in you get the odd bug report anyway.
> 
> Basically you can't win and unfortunately a shrink wrap forcing the user
> to read the README file for the kernel violates the GPL ..
> 
> Jaded, me ?
> 
> Alan

I fear that you are speaking from experience about the complaints it doesn't
build, and that there is a strong element of truth in what you say.

That said, my opinion is that bug reporting load is not as important as bug
avoidance, but I understand your position has merit to it also.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
