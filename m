Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271797AbRH1QJD>; Tue, 28 Aug 2001 12:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271798AbRH1QIx>; Tue, 28 Aug 2001 12:08:53 -0400
Received: from ns.suse.de ([213.95.15.193]:50186 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271797AbRH1QIs>;
	Tue, 28 Aug 2001 12:08:48 -0400
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108280617250.8365-100000@penguin.transmeta.com>
	<3B8BA883.3B5AAE2E@linux-m68k.org>
X-Yow: I'm mentally OVERDRAWN!  What's that SIGNPOST up ahead?
 Where's ROD STERLING when you really need him?
From: Andreas Schwab <schwab@suse.de>
Date: 28 Aug 2001 18:09:00 +0200
In-Reply-To: <3B8BA883.3B5AAE2E@linux-m68k.org> (Roman Zippel's message of "Tue, 28 Aug 2001 16:19:47 +0200")
Message-ID: <je4rqsdv4z.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.105
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

|> Hi,
|> 
|> Linus Torvalds wrote:
[...]
|> > You just fixed the "re-use arguments" bug - which is a bug, but doesn't
|> > address the fact that most of the min/max bugs are due to the programmer
|> > _indending_ a unsigned compare because he didn't even think about the
|> > type.
|> 
|> You maybe fixed a few bugs, but this new macro will only cause new
|> problems in the future. If we change only a single type, you have to
|> scan all min/max users if they possibly need to be changed too. Thanks
|> to the cast, the compiler won't even remotely help you finding them.

There is no cast in the min/max macros.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
