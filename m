Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbRGQUKQ>; Tue, 17 Jul 2001 16:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbRGQUKH>; Tue, 17 Jul 2001 16:10:07 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:48228 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266996AbRGQUJ6> convert rfc822-to-8bit; Tue, 17 Jul 2001 16:09:58 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "Dominick, David" <David.Dominick@delta.com>, linux-kernel@vger.kernel.org
Subject: Re: sound?!?!!?
Date: Tue, 17 Jul 2001 22:08:42 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <BDEE1F50C0C6D411BBB600204840D7B40124F17D@satlrccdmrus25.delta-air.com>
In-Reply-To: <BDEE1F50C0C6D411BBB600204840D7B40124F17D@satlrccdmrus25.delta-air.com>
MIME-Version: 1.0
Message-Id: <01071722084200.03038@Einstein.P-netz>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it is most likely a problem with me, but I have tried everything and I keep
> getting the error that device not found or busy. I get this rather I use

Possibly you already tried this, then ignore my ideas:

First idea:
It might be a stupid idea, as I don´t know your Toshiba but try to change the 
PnP OS option in the BIOS. (from yes to no or from no to yes)
If you don´t have success set it back, of course.

Second idea:
Have you activated ISA PnP in the Kernel?
/proc/isapnp must exist and the sound module should be loaded after the 
isaPnP support. 
If /proc/isapnp exists, what is sndconfig doing?

Good Luck.
