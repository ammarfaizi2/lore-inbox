Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131237AbRABToy>; Tue, 2 Jan 2001 14:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131378AbRABToo>; Tue, 2 Jan 2001 14:44:44 -0500
Received: from gw.brfsodrahamn.se ([195.54.141.30]:26163 "HELO
	tuttifrutti.cdt.luth.se") by vger.kernel.org with SMTP
	id <S131237AbRABTog> convert rfc822-to-8bit; Tue, 2 Jan 2001 14:44:36 -0500
X-Mailer: exmh version 2.2 10/15/1999 with nmh-1.0.4
From: Hakan Lennestal <hakanl@cdt.luth.se>
Reply-To: Hakan Lennestal <hakanl@cdt.luth.se>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hakan Lennestal <hakanl@cdt.luth.se>,
        David Woodhouse <dwmw2@infradead.org>,
        Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts.... 
In-Reply-To: Your message of "Tue, 02 Jan 2001 10:42:55 PST."
             <Pine.LNX.4.10.10101021038410.25012-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 02 Jan 2001 20:15:55 +0100
Message-Id: <20010102191600.511DD4185@tuttifrutti.cdt.luth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.10.10101021038410.25012-100000@penguin.transmeta.com>, L
inus Torvalds writes:

> So why are the IBM drives picked on? I thought this was a hpt366 problem,
> and possibly has only shown up with IBM drives so far.

Yes, the problem is the hpt366 (or the sw), not the IBM drives.
The IBM drives seem to work well with udma3 on the hpt but not 
with udma4 or higher.

> It sounds like the proper fix would be to not enable ata66 by default.

Yes, either that or the bad_ata66_4 list in hpt366.c. 
The important thing is to have a bootable system.

Regards.

/Håkan


---------------------------------------
e-mail: Hakan.Lennestal@lu.erisoft.se |
     or Hakan.Lennestal@cdt.luth.se   |
---------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
