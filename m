Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282784AbRLTJJw>; Thu, 20 Dec 2001 04:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282757AbRLTJJn>; Thu, 20 Dec 2001 04:09:43 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:3338 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282784AbRLTJJ1>; Thu, 20 Dec 2001 04:09:27 -0500
Date: Thu, 20 Dec 2001 09:01:39 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Stevie O <stevie@qrpff.net>
Cc: "David S. Miller" <davem@redhat.com>, Mika.Liljeberg@welho.com,
        kuznet@ms2.inr.ac.ru, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Message-ID: <20011220090139.B29925@flint.arm.linux.org.uk>
In-Reply-To: <3C1FA558.E889A00D@welho.com> <200112181837.VAA10394@ms2.inr.ac.ru> <3C1FA558.E889A00D@welho.com> <20011218.122813.63057831.davem@redhat.com> <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net>; from stevie@qrpff.net on Thu, Dec 20, 2001 at 02:31:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:31:44AM -0500, Stevie O wrote:
> I don't know what arch you're using, but I work with ARM7TDMI, which has a 
> behavior I believe can be found documented in some obscure .pdf from arm.com:

Sorry, it's not an obscure PDF.  It's documented in the Architecture
Reference Manual, which is the main reference for the behaviour of any
ARM processor.  If you don't have that, then you're missing *vital*
information.

> At least, that's how ARM's docs seem to describe it. I work with this cpu 
> embedded in a microcontroller (AT91M40800), and these values result:
> 
> *(int*)0x00 == 0x33221100
> *(int*)0x01 == 0x33221100
> *(int*)0x02 == 0x33221100
> *(int*)0x03 == 0x33221100
> *(int*)0x04 == 0x77665544

Looks like some random manufacturer decided to do something different.
Nothing out of the ordinary there. 8(

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

