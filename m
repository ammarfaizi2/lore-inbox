Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRKOLxJ>; Thu, 15 Nov 2001 06:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRKOLw7>; Thu, 15 Nov 2001 06:52:59 -0500
Received: from [194.90.137.3] ([194.90.137.3]:32523 "EHLO MAILGW")
	by vger.kernel.org with ESMTP id <S275224AbRKOLwq>;
	Thu, 15 Nov 2001 06:52:46 -0500
Date: Thu, 15 Nov 2001 13:52:38 +0200
From: Michael Rozhavsky <mrozhavsky@opticalaccess.com>
To: Marco Schwarz <mschwarz_contron@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to set speed for EEPro100 ?
Message-ID: <20011115135238.D5982@opticalaccess.com>
In-Reply-To: <20011115114301.51726.qmail@web10307.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011115114301.51726.qmail@web10307.mail.yahoo.com>; from mschwarz_contron@yahoo.de on Thu, Nov 15, 2001 at 12:43:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If you use default eepro100.o module supplied with Linux kernel then
you have two options:
- add 'options eepro100 options=0x10' to your conf.modules
- use mii-diag program to change the speed/duplex of the card

If you use Intel driver called e100 then add the following line
to your conf.modules file

'options e100 e100_speed_duplex=2'

On Thu, Nov 15, 2001 at 12:43:01PM +0100, Marco Schwarz wrote:
> Hi,
> 
> I am having some problems with my EEPro 100 card.
> Seems like my dual speed hub doesnt like it when some
> of the cards are 10 MB and some others are 100 ....
> 
> How can I force the card to use 10 MB instead of 100MB
> or auto detect ? I am using the driver included in
> kernel 2.4.9, and I couldnt find any infos on how to
> do this ... 
> 
> Thanks in advance
> 
> Marco Schwarz
> 
> 
> __________________________________________________________________
> 
> Gesendet von Yahoo! Mail - http://mail.yahoo.de
> Ihre E-Mail noch individueller? - http://domains.yahoo.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Best regards.

--
   Michael Rozhavsky			Tel:    +972-4-9936248
   mrozhavsky@opticalaccess.com		Fax:    +972-4-9890564
   Optical Access  
   Senior Software Engineer		www.opticalaccess.com
