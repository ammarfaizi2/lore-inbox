Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbTBKJhP>; Tue, 11 Feb 2003 04:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbTBKJf7>; Tue, 11 Feb 2003 04:35:59 -0500
Received: from ns.suse.de ([213.95.15.193]:22022 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267347AbTBKJfd>;
	Tue, 11 Feb 2003 04:35:33 -0500
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Art Haas <ahaas@airmail.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       brand@eeyore.valparaiso.cl
Subject: Re: Is -fno-strict-aliasing still needed?
X-Yow: Who wants some OYSTERS with SEN-SEN an' COOL WHIP?
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 11 Feb 2003 10:45:19 +0100
In-Reply-To: <200302110939.h1B9dX6T013616@eeyore.valparaiso.cl> (Horst von
 Brand's message of "Tue, 11 Feb 2003 10:39:33 +0100")
Message-ID: <jey94nb174.fsf@sykes.suse.de>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.3.50 (ia64-suse-linux)
References: <200302110939.h1B9dX6T013616@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <brand@jupiter.cs.uni-dortmund.de> writes:

|> Andreas Schwab <schwab@suse.de> said:
|> > Horst von Brand <brand@jupiter.cs.uni-dortmund.de> writes:
|> > 
|> > |> Art Haas <ahaas@airmail.net> said:
|> > |> > I ask because I've just built a kernel without using that flag -
|> > |> > linus-2.5 BK from this morning, probably missing the 2.5.60 release by
|> > |> > a few hours.
|> > |> 
|> > |> The problem with strict aliasing is that it allows the compiler to assume
|> > |> that in:
|> > |> 
|> > |>      void somefunc(int *foo, int *bar)
|> > |> 
|> > |> foo and bar will _*never*_ point to the same memory area
|> > 
|> > This is wrong.  Only if they are declared restrict.
|> 
|> ... can they point to the same area. That is exactly the problem: If you do
|> nothing, the language definition assumes the programmer made sure (LOL!)
|> that they don't point the same way.

Why are you insisting on spreading misinformation?

Pointers that are _not_ declared as restricted can alias _any_ other
non-restricted pointer of the same target type.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
