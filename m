Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBEMIN>; Mon, 5 Feb 2001 07:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBEMIE>; Mon, 5 Feb 2001 07:08:04 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:48388 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129027AbRBEMH5>; Mon, 5 Feb 2001 07:07:57 -0500
Message-ID: <3A7E9010.4D6842D1@namesys.com>
Date: Mon, 05 Feb 2001 14:35:44 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Brian Wolfe <ahzz@terrabox.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink 
 related)
In-Reply-To: <E14PkEo-0003B2-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > administrator that has worked in large multi hundred million dollar compani=
> > es where 1 hour of downtime =3D=3D $75,000 in lost income proactive prevent=
> > ion IS the right answer. If the gcc people need to compile with the .96 rh =
> > version then they can apply a removal patch hans provides in the crash mess=
> > age. This makes it easy to remove the safeguard and blow yourself up at wil=
> > l after being suitibly called a dumbass.
> 
> With all due respect, if you are running $75,000/hr of lost income (which btw
> is small fry to a lot of folks) shouldn't you have an engineering team who
> a) read the documentation.
> b) run tests before rolling out software
> 
> Alan


Think of it as being like gun safety.  You don't seek to develop habits that
protect you when you are awake and alert and paying attention, you strongly seek
to develop the sort of habits that will protect you if for one moment your
attention wanders and you do something completely stupid.  Oh dear, there may be
some cultural translation difficulty with this example.:-)

User protection is a variant on that.  To have an attitude that if the user was
only alert and intelligent at the moment and as educated as you are in how to
compile a kernel, this is just, ahem, not right. 

All things must be kept in balance though, and not taken to extremes.  But when
the number of users complaining exceeds some amount relative to the cost to
protect them, they should be protected from their lack of education in what
distro to not trust the compiler on.

You can go ahead and write software for the always alert and always intelligent
and never too hasty and always read the README users, and I'll be happy with
having the rest of the market for ReiserFS.:-)

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
