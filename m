Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281679AbRKUOTq>; Wed, 21 Nov 2001 09:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281675AbRKUOT0>; Wed, 21 Nov 2001 09:19:26 -0500
Received: from ns.suse.de ([213.95.15.193]:5132 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281381AbRKUOTT> convert rfc822-to-8bit;
	Wed, 21 Nov 2001 09:19:19 -0500
To: Jan Hudec <bulb@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <01112112401703.01961@nemo>
	<20011121133115.A1451@ragnar-hojland.com>
	<20011121144034.E2196@artax.karlin.mff.cuni.cz>
X-Yow: YOW!!
From: Andreas Schwab <schwab@suse.de>
Date: 21 Nov 2001 15:19:13 +0100
In-Reply-To: <20011121144034.E2196@artax.karlin.mff.cuni.cz> (Jan Hudec's message of "Wed, 21 Nov 2001 14:40:34 +0100")
Message-ID: <jey9l09pge.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec <bulb@ucw.cz> writes:

|> > On Wed, Nov 21, 2001 at 12:40:17PM +0000, vda wrote:
|> > If you wanna do this type of cleanup, you can take it one step forward;
|> > remember that the order of evaluation of foo and bar doesn't have to be
|> > {foo => bar} so it can be {bar => foo}  I hope gcc's behaviour doesn't
|> > change under our feet.
|> > 
|> > 	a = foo (i) + bar (j);
|> > 
|> > .. sprinkle some pointer arithmetic over there for fun ;)
|> 
|> AFAIK here the order *IS* defined. + operator is evaluated left to right

No.  It is undefined which of the operator's arguments is evaluated first,
unless it is defined otherwise (only for ||, && and comma).

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
