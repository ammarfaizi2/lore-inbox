Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129866AbQLKGCn>; Mon, 11 Dec 2000 01:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQLKGCY>; Mon, 11 Dec 2000 01:02:24 -0500
Received: from alex.intersurf.net ([216.115.129.11]:17668 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S129866AbQLKGCP>; Mon, 11 Dec 2000 01:02:15 -0500
Message-ID: <XFMail.20001210233147.markorr@intersurf.com>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.21.0012110115300.26828-100000@server.serve.me.nl>
Date: Sun, 10 Dec 2000 23:31:47 -0600 (CST)
Reply-To: Mark Orr <markorr@intersurf.com>
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Dropping chars on 16550
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11-Dec-2000 Igmar Palsenberg wrote:
> On Sun, 10 Dec 2000 clock@ghost.btnet.cz wrote:
> 
>> Hi folks
>> 
>> What should I do, when I run cdda2wav | gogo (riping CD from a ATAPI
>> CD thru mp3 encoder) and get a continuous dropping of characters, on a
>> 16550-
>> enhanced serial port, without handshake, with full-duplex load of 115200
>> bps?
>> About 1 of 320 bytes is miscommunicated.
> 
> Use handshaking

Heh...do what I did.  Go on eBay and pick up a Hayes ESP card.

I have a fairly weak system by todays standards, and I found that
even with a 16550 serial port, I'd get tcp/ip errors in my logs
(and lots of 'em).

They never wrote decent ESP drivers for Windows, but the
Linux drivers are superb.   I popped it in, configured it,
and the tcp errors vanished...not a single one in the 10 months
I've owned it.

It bugs me that they're making PC's w/o ISA cards now, because
I dont wanna give up my Hayes ESP.   Based on what I saw, a 16550
with it's tiny 16-byte buffer, isnt enough.

(yes, I'm stuck with POTS+PPP.  Cable modems are available...
but the ISP is @Hoax.  Yuck.   The only DSL grade I can get is
IDSL -- $70/month.  Double yuck.)

--
Mark Orr
markorr@intersurf.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
