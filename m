Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTLUOR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTLUOR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:17:29 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263125AbTLUOR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:17:26 -0500
Date: Sun, 21 Dec 2003 14:23:31 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312211423.hBLENVX0000219@81-2-122-30.bradfords.org.uk>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>, <linux-kernel@vger.kernel.org>
In-Reply-To: <0d6001c3c7b2$bbf900b0$43ee4ca5@DIAMONDLX60>
References: <0d6001c3c7b2$bbf900b0$43ee4ca5@DIAMONDLX60>
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from "Norman Diamond" <ndiamond@wta.att.ne.jp>:
> John Bradford wrote:
> 
> > The placement of some keys seems to have changed over time.
> 
> IBM used to change key placements once or twice per sub-model of any model
> of keyboard.  Other manufacturers made various changes too.  Things settled
> down around 20 years ago.

Good - so we can agree that there is an easy to define layout that the
vast majority of people are used to.  That's great.

> > tilde was once shift-0, whilst shift-caret was once overbar.
> 
> I don't know why most keyboards still show a tilde on the 0 (zero) key, but
> I've never seen it produce any input except in Linux.  Most keyboards still
> show an overbar on the caret key but most fonts during the past 10 years
> display it as tilde.

Let's try to avoid thinking in terms of how a font displays it at this
point, because that just adds another source of confusion - we all
know that tilde and overbar, pipe and bar, caret and up-arrow, are
often used interchangably in fonts.  It's the character code it gets
translated in to that's relevant here.

> > Backslash and Yen share the same code in 8-bit variations of
> > ASCII-based.  Therefore, the lower-right backslash key and the
> > upper-right Yen key may in some cases be used interchangably.
> 
> In all cases, except on some IBM model that was more than 20 years old.

OK, again, this is good.  I didn't want to make a general assumption
based on a small dataset.

> Of
> course the scan codes are different, which is necessary because the shifted
> characters are different

Yes.

> > and I personally think it would be a good idea to default to the
> traditional key-mappings, so that these characters can be easily input on
> systems which correctly support them.
> 
> That would be sort of like requiring all Linux users to learn the Dvorak
> layout because typing is easier (faster) for users who have already learned
> the Dvorak layout.  That would alienate the mass majority who learned to use
> a more common national layout.  After all the reason these national layouts
> remain common is because of the mass majorities who already learned them.
> It is the same in Japan.  You have to let ordinary keys work the way they
> traditionally have.
> 
> By the way, you used the word "traditional" where I think the fact is
> "archaic and even then only on some fraction of keyboards."  I used the word
> "traditionally" for keyboards as they've been used for the past 20 years.

What I meant was the layout that is traditionally in use -
I.E. today's common layout.

> > As I understand it there was traditionally a distinction between pipe,
> > (a broken vertical line), and bar, (solid vertical line).
> 
> Archaically in one manufacturer's character set I think.  I saw the same
> distinction in one manufacturer's US EBCDIC character set too, but never saw
> both characters on any card punch, printer, or terminal.
> 
> > Pipe is the fourth character on the lower-right backslash key.
> > Bar is the second character on the upper-right yen key.
> 
> The one that is always used as a pipe or or-bar is the shifted form of the
> upper-right yen key.
> 
> The one that you see as the shifted form of the direct kana input mode of
> the lower-right backslash key is another one of those that produces no
> input.  There are a few more that you didn't mention.  Japanese keyboards
> also often have markings for a British pound sign, US cent sign, Kanji
> repetition marker, rectangular logical not character, and an extra pair of
> quotation marks, as shifted forms of direct kana input mode of some keys.
> But those also produce no input.  These also I think only produced input in
> one manufacturer's archaic character set, I think.  JIS-Romaji (single byte
> code points in the range 0 to 127) certainly do not include a British pound
> sign, US cent sign, backslash, more than one vertical bar, or more than one
> of tilde and overbar.  Some manufacturers sensibly decline to print these
> non-existent characters on the keys of their keyboards.

Ah, but they are _not_ non-existant anymore.

We have moved on from 0 - 127, ASCII-based character sets.  Unicode,
for example, includes all of the symbols you mention.

A modern X-based word-processing application will typically allow the
use of Yen, backslash, British pound sign, US cent sign, tilde, and
pipe, so why shouldn't we be able to type these symbols easily?

John.
