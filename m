Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265043AbRGEMl5>; Thu, 5 Jul 2001 08:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbRGEMlq>; Thu, 5 Jul 2001 08:41:46 -0400
Received: from mail.ftr.nl ([212.115.175.146]:60153 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S265043AbRGEMlc>; Thu, 5 Jul 2001 08:41:32 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F1558@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Anuradha Ratnaweera <anuradha@gnu.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: chuckw@altaserv.net, Vipin Malik <vipin.malik@daniel.com>,
        Aaron Lehmann <aaronl@vitelus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: RE: Cosmetic JFFS patch.
Date: Thu, 5 Jul 2001 14:41:26 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Leave the copyright messages alone is all I can say. And as to your flag,
> well we've got one. Try the 'quiet' boot option
YOU> Leaving copyright messages also saves the purpose of motivating - not
all but
YOU> many - developers.  People who _see_ the printk copyright messages is a
_very_
YOU> large superset of people who _look_ at source code, or ChangeLog /
CREDITS /
YOU> MAINTAINERS files.
YOU> After all many copyright messages are not that annoying.

Suggestion: make the buffer-size for these messages configurable at make
config -time.
So; people can define wether they want the message or not. If size=0, the
printk-thing
could be replaced with
#define printk(x)  /*nothing*/
Nice for the embedded linux-system people.


Greetings,

Folkert van Heusden
[ www.vanheusden.com ]
