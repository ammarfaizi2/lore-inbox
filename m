Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130054AbRCGEK2>; Tue, 6 Mar 2001 23:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130062AbRCGEKI>; Tue, 6 Mar 2001 23:10:08 -0500
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:8964
	"HELO ns1.theoesters.com") by vger.kernel.org with SMTP
	id <S130054AbRCGEJ5>; Tue, 6 Mar 2001 23:09:57 -0500
From: "Phil Oester" <phil@theoesters.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Error compiling aic7xxx driver on 2.4.2-ac13
Date: Tue, 6 Mar 2001 20:09:15 -0800
Message-ID: <LAEOJKHJGOLOPJFMBEFEEEBJCNAA.phil@theoesters.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E14aSAu-0001pw-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I actually had the problem with lack-of-lex also, but worked through that...

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
Sent: Tuesday, March 06, 2001 4:51 PM
To: J . A . Magallon
Cc: Phil Oester; linux-kernel@vger.kernel.org
Subject: Re: Error compiling aic7xxx driver on 2.4.2-ac13


> Which distro is yours ? In my Mandrake 8.0beta there is no
/usr/include/db.
> Mdk offers the 3 db libs (db1, db2, db3), so I had to create a symlink
> /usr/include/db3 -> /usr/include/db.
>
> Which is the standard path ? At least, Mdk and RH (Alan...) differ.

Im not too worried about this right now since as Al Viro pointed out the
libdb use is unneeded.

The irony of all this was that the real concern Justin had and discussed
with
people was about lex/bison/yacc being available, and the problem has been db
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


