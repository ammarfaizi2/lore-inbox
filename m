Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRBTDdF>; Mon, 19 Feb 2001 22:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbRBTDcq>; Mon, 19 Feb 2001 22:32:46 -0500
Received: from relay1.pair.com ([209.68.1.20]:60431 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S129166AbRBTDcf>;
	Mon, 19 Feb 2001 22:32:35 -0500
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010220033145.8260.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: ethernet driver probs (tulip, de4x5, 3c509)
In-Reply-To: <Pine.LNX.3.96.1010219085051.17842D-100000@mandrakesoft.mandrakesoft.com>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
In-Reply-To: Jeff Garzik's message of "Mon, 19 Feb 2001 08:52:15 -0600 (CST)"
Organization: rows-n-columns
Date: 20 Feb 2001 14:31:45 +1100
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> On 20 Feb 2001, Manfred Bartz wrote:
> > I have 3 NICs (2*DEC, 1*3c509) in my gateway (P75, 40M RAM).
> > 
> > tulip.o in 2.4.1 insists on selecting 10baseT, no command
> > line option can convince it otherwise.  tulip.o in 2.2.16 auto
> > detected media and worked fine.
> 
> A little info on your cards would be helpful.  With well over 100
> different types of Tulip cards, I can't just read your mind :)

The problem seems to be generic.  It is always related to media
selection and occurs with at least 3 different NICs which are based 
on the 21040 and 21041 chips.

> lspci, tulip-diag, and dmesg output would all be helpful.

I have not got lspci but since the driver reports the correct IRQ and
IO-ports that should be no issue.  (I'll install lspci if necessary).

Outputs of dmesg, tulip-diag, and some other info is now at:
        <http://www.logi.cc/tulip/>

> > de4x5.o in 2.4.1 needs to be told the media, then works fine.
> > de4x5.o in 2.2.16 auto detected media and worked fine.
> 
> de4x5 is going away, anyway.

Pity.  It works and I really like the manual options interface...   :/

-- 
Manfred
