Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272158AbRH3KuE>; Thu, 30 Aug 2001 06:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272163AbRH3Kty>; Thu, 30 Aug 2001 06:49:54 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:63249 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S272158AbRH3Ktp>;
	Thu, 30 Aug 2001 06:49:45 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: HW ethernet address problems with 8139too and 2.4.9
Date: 30 Aug 2001 10:17:19 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9os4lf.469.kraxel@bytesex.org>
In-Reply-To: <15820.999163539@www56.gmx.net>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 999166639 4298 127.0.0.1 (30 Aug 2001 10:17:19 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Christian Armingeon wrote:
>  Hi gurus,
>  I've got a problem with an Elitegroup K7AMA onboard rtl8139C LAN.
>  ifconfig shows me the hardware address ff:ff:ff:ff:ff:ff. So I'm not 
>  able to get an tcp/ip connection. Under w2k professional everything works
>  fine.
>  Any suggestions?

The f*** rtl windows driver does that.  You can do:

(1) stop booting windows
(2) ifconfig eth0 hw ether ...  at a reasonable place in the boot
    scripts

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
