Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSCCUke>; Sun, 3 Mar 2002 15:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSCCUka>; Sun, 3 Mar 2002 15:40:30 -0500
Received: from ishtar.tlinx.org ([64.81.58.33]:12012 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id <S288958AbSCCUkL>;
	Sun, 3 Mar 2002 15:40:11 -0500
Reply-To: <law@tlinx.org>
From: "LA Walsh @ tlinx.org" <law@tlinx.org>
To: "J Sloan" <joe@tmsusa.com>, "janvapan" <jvp@wanadoo.es>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Recommendations about a 100/10 NIC
Date: Sun, 3 Mar 2002 12:39:55 -0800
Message-ID: <NFBBKNPJLGIDJFAHGKMBEENKCBAA.law@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Importance: Normal
In-Reply-To: <3C825A19.5070204@tmsusa.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any recommendations for the most  Linux-friendly/best performance,
2-ethernet port cards?  Is there a website one could go to find Linux
Compatible and Linux-ease-of-use hardware and software products?  Comparisons?
Etc?

TIA,
Linda


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of J Sloan
Sent: Sunday, March 03, 2002 9:15 AM
To: janvapan
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recommendations about a 100/10 NIC

In my humble experience with some hundreds
of different Linux servers, the 3c905 seems the
most trouble-free, and performs well.

The Intel adapter has potential driver issues,
although they seem to be getting resolved.

The e100 driver has the disadvantage of being
unable to work with the mii-tool commands,
but seems to work well otherwise - as long as
you don't mind trying to puzzle out whether
the card is conected at 10 or 100, full or half.

The eepro100 driver works with mii-tool, but
many have reported issues with the card dying
under heavy use and needing to be reset. Many
are using the eepro100 without problems - but
the bottom line is that nobody is seeing these
problems with the 3com cards.

YMMV of course -

Joe


janvapan wrote:

>What ethernet cards I should use for Linux 2.4?.
>I am looking for a NIC based on stability and performance.
>In short, Intel PRO/100 S Desktop Adapter(e100 driver) or
>3Com 10/100 3C905C-TX-M(3c59x driver) ?
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

