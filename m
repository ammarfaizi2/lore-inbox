Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBAGf6>; Thu, 1 Feb 2001 01:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRBAGfs>; Thu, 1 Feb 2001 01:35:48 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:17673 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S129075AbRBAGfb> convert rfc822-to-8bit; Thu, 1 Feb 2001 01:35:31 -0500
Date: Thu, 1 Feb 2001 03:35:35 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VIA IDE problems related to heat?
Message-ID: <20010201033535.A576@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for confirmations on any kind of correlation between
the problems people have been having with the assorted VIA IDE
chipsets and possible overheating of said chipsets.

I'm asking because I suffered from the VIA-chipset-ate-my-data
bug, and I've been trying to reproduce it to no avail. The only
thing I haven't been able to recreate is the heat (ambient was
~35C (~95F) at the time), and noticing that now with ambient at
~25C (80F) the heatsink of the 694x quickly hits ~40 when doing
heavy I/O, whereas most articles I've read seem to think 25-30C
is about right, and that I was doing this heavy i/o thing when
the bug bit...

if any of you know what temperature this thing _should_ be, and
further if y'all could get onto those chipsets with thermometers
to see if we have a temp vs. crashes distribution, we might be
onto something.

Or maybe not.

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
La humanidad es como es. No se trata de cambiarla, sino de conocerla.
		-- Gustave Flaubert. (1821-1880) Escritor francés. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
