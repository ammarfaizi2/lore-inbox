Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbRE3IUq>; Wed, 30 May 2001 04:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbRE3IUf>; Wed, 30 May 2001 04:20:35 -0400
Received: from [216.74.100.93] ([216.74.100.93]:15109 "EHLO
	host7.hrwebservices.net") by vger.kernel.org with ESMTP
	id <S262649AbRE3IUV>; Wed, 30 May 2001 04:20:21 -0400
Message-ID: <000501c0e92c$efb19780$c1a5fea9@spunky>
Reply-To: <james@spunkysoftware.com>
From: <james@spunkysoftware.com>
To: "Francois Romieu" <romieu@cogenit.fr>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E154VOJ-0003cy-00@the-village.bc.nu> <004601c0e811$f8c93d80$c1a5fea9@spunky> <20010529122109.A5196@se1.cogenit.fr> <015601c0e8de$0e936ba0$c1a5fea9@spunky> <20010530094004.A14129@se1.cogenit.fr>
Subject: Re: Creative 4-speed CDROM driver
Date: Wed, 30 May 2001 18:21:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you've mistaken my tone  :-)

I wasn't asking anyone to write the driver for me. But, I am at such a
beginning position that I could pull my hair out for a year just trying to
get an idea where to start, or I can ask someone. I am absolutely prepared
to do the work, however I am not prepared to waste my time looking at
irrelevant things or doing something that results in nothing.

What I am after is for someone to spell it out plain and clear: do this,
then this, then this, whatever these things might be. (Get a book on IBM PC
architecture, contact the manufacturer for a document which is called blah
blah, or whatever these things are). I have all the standards documents now,
and which parts to implement? You can see my problem. I am a beginner, and I
am asking (I hope) fairly simple questions on where I should start, so I can
cut some code and do some learning, get my device working and send the
driver for everyone to download at comp.os.minix.

You see, I can't even begin to write one line of code, because I know
nothing about what I am supposed to do. Sure, I know the basics, I have
written toy device drivers for Linux, I know how to implement a driver for
Minix, understand the main loop, handling messages from the Minix kernel,
how to fill in a device structure correctly with pointers to functions that
implement the device independant interface, etc. I know this stuff, that's
not a problem. My problem is what is the I/O address range? Can I access it
in C? Do I use DMA? When there are commands that can be implemented (set A,
I'll call them) and another set of functions when the device uses the ATA
Packet Interface (I'll call them set B) then which set? And the standard of
ATAPI makes it clear that the Packet Interface is elsewhere, not defined in
the ATAPI document.

I could go around and around in ever decreasing circles until I disappear up
my own arse looking in all the wrong places and pulling my hair out. I am
absolutely determined to write this driver. I will spend a year on it. Big
deal. I have plenty of time. But I need someone who has done this or who
knows how to do it to point me in the right direction so I can do it for
myself. I am no dummy, just the URL to a document will do, I will do the
actual reading and digesting the document.

Problem so far is that I didn't spell it out clearly enough that I am a
beginner, and I had vague and incomprehensible emails from those who know
what they are doing, assuming they are speaking to someone of equal
knowledge. This I am not (although I plan to be, and can be when someone
points me in the right direction.)

Thanks for writing to me. I appreciate your time very much.

James


----- Original Message -----
From: "Francois Romieu" <romieu@cogenit.fr>
To: <james@spunkysoftware.com>
Sent: Wednesday, May 30, 2001 8:40 AM
Subject: Re: Creative 4-speed CDROM driver


james@spunkysoftware.com <james@spunkysoftware.com> écrit :
> How do you think I should go about writing this driver? So the standards
> documents are not the best way to go? What else is there for me to write

I've never said that. They are. I was simply outlining that drivers are
written by people with *some* background in the specific field. If they
don't have it, it takes them time to get it and have a satisfying driver.

It's not a 5 minutes/hours hack except maybe for someone that knows how
Linux/Minix/Atapi/your specific cdrom work. IMHO such a person will be
too busy now for others reasons. Thus, if you want it working, you have
to invest your own time and walk the learning curve. It takes time
however. See ?

--
Ueimor



