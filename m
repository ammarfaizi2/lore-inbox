Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbSKUKgf>; Thu, 21 Nov 2002 05:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSKUKgf>; Thu, 21 Nov 2002 05:36:35 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:59918 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S266527AbSKUKge>; Thu, 21 Nov 2002 05:36:34 -0500
Message-ID: <20021121103437.50614.qmail@iname.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "L P" <plm@iname.com>
To: "Daniela Engert" <dani@ngrt.de>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 21 Nov 2002 18:34:37 +0800
Subject: Re: Problems Hot-Swapping IDE ATA drives
X-Originating-Ip: 212.199.10.23
X-Originating-Server: ws1-9.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Daniela,
> There is a problem with PCMCIA<->ATA adapters and "True IDE mode":
> 
> A CompactFlash unit enters "True IDE mode" when the /OE pin is held low
> at device power on. This is fine when your system is powered on with
> the CF card inserted. But if you insert a CF card into an already
> powered on system, the /OE pin is not connected to the socket and thus
> held high by an device-internal pull up at device power on. This is
> because the power pins are longer than the other pins and connected
> before the others! So the CF card enters "memory mapped mode" instead
> of "True ATA mode" and is no longer accessible from the ATA host.

    Many many thanks to you for the hint - I added the On/Off switch on the adapter power and everything now works fine! I insert cassette, cycle the power and mount the drive - it works!
    Once again - many thanks.

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

