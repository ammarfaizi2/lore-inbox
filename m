Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbRGFTDG>; Fri, 6 Jul 2001 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266804AbRGFTC5>; Fri, 6 Jul 2001 15:02:57 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50112 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266808AbRGFTCn>;
	Fri, 6 Jul 2001 15:02:43 -0400
Message-ID: <3B46038D.5DA023B6@mandrakesoft.com>
Date: Fri, 06 Jul 2001 14:29:33 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ariel Molina Rueda <amolina@fismat.umich.mx>
Cc: linux-kernel@vger.kernel.org, Adrian Cox <adrian@humboldt.co.uk>
Subject: Re: Via82cxxx Codec rate locked at 48Khz
In-Reply-To: <Pine.LNX.4.33.0107061215400.32589-100000@garota.fismat.umich.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ariel Molina Rueda wrote:
> 
> Greetings:
> 
> When i used Redhat 7 and kernel 2.2.x y was happy with my souncard, now I
> use RedHat 7.1 and Kernel 2.4.x, but sndconfig doesn't configure my
> Via82c686 soundcard at all. At the ending it says
> 
> via82cxxx codec rate locked at 48khz
> 
> I use a Biostar MKE401B Matherboard with on-board sound (AC97)
> 
> I've heard about patches for the intel chipsets, does anybody knows if one
> for my card has been released, or how to fix this problem...
> (my sound is  choppy and XMMS crashes!)
> 
> something weird is that sound is good when Linus says:
> "Hi, Im Linus Torvalds, and...."
> then after sndconfig ends and sound is crying...

Kernel 2.4.6 definitely includes fixes.

For the message "Codec rate locked at 48Khz", that is a hardware
limitation of your codec.  You need to find software which supports
software rate conversion, so that you may play music at speeds other
than 48Khz.

	Jeff


-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
