Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTJQOLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 10:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbTJQOLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 10:11:52 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:19878 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263420AbTJQOLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 10:11:51 -0400
Message-ID: <14ed01c394b8$5e5332f0$3eee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Hans Reiser" <reiser@namesys.com>, "Wes Janzen" <superchkn@sbcglobal.net>,
       "Rogier Wolff" <R.E.Wolff@BitWizard.nl>,
       "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "Pavel Machek" <pavel@ucw.cz>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60> <3F8FBADE.7020107@namesys.com> <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60> <20031017140428.B2415@flint.arm.linux.org.uk>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Date: Fri, 17 Oct 2003 23:09:40 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This question from Russell King was public...

> On Fri, Oct 17, 2003 at 08:11:42PM +0900, Norman Diamond wrote:
> > Russell King replied to me:
> > > > When a drive tries to read a block, if it detects errors, it retries up
> > > > to 255 times.  If a retry succeeds then the block gets reallocated.  IF
> > > > 255 RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.
> > >
> > > This is perfectly reasonable.  If the drive can't recover your old data
> > > to reallocate it to a new block, then leaving the error present until you
> > > write new data to that bad block is the correct thing to do.
>
> Why the F**K are you replying to me publically when I sent my reply in
> private?

First to answer literally, the reasons are:
(1)  Everything else in this discussion have been public with additional
copies to individuals participating in the discussion.  (The same has been
true of most messages in other LKML discussions that I've seen.)
(2)  I didn't notice anything in your previous message that looked like it
needed to be kept secret, i.e. deliberately not posted publicly.

Now taking it non-literally, obviously I owe you an apology.  I should not
have quoted any of your words publicly without asking you first.  I am sorry
for quoting you without asking.

Now taking it intellectually, I am genuinely puzzled.  Sorry to repeat, but
I didn't notice anything in your previous message that looked like it needed
to be kept secret, i.e. deliberately not posted publicly.  Why was your
previous message private?

Sincerely,
Norman Diamond

