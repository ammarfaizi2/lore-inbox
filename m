Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272216AbTGYQOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 12:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272217AbTGYQOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 12:14:10 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:35970 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272216AbTGYQOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 12:14:06 -0400
Date: Fri, 25 Jul 2003 17:39:11 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307251639.h6PGdBfv001556@81-2-122-30.bradfords.org.uk>
To: aebr@win.tue.nl, john@grabjohn.com
Subject: Re: Japanese keyboards broken in 2.6
Cc: cs@tequila.co.jp, linux-kernel@vger.kernel.org, ndiamond@wta.att.ne.jp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > One aspect of the matter is that raw mode no longer is raw.
> > > The keyboard sends codes and the input layer translates that into
> > > the codes the input layer thinks the keyboard should have sent.
> > > Then, when one wants the raw codes, a reverse translation is used,
> > > but since the mapping is not one-to-one the reverse translation
> > > does not produce what the keyboard sent to start with.
> > 
> > Doesn't AT-set3 usually have a closer one to one mapping of keys?
>
> Sorry - I am unable to make sense of your question.

The reason I mentioned it is because I've got a keyboard which
physically has a Japanese layout, but emulates a US keyboard in set 2.

Some keys which are shifted on a US keyboard, are not shifted on a
Japanese keyboard, for example, the colon key.  Presing colon on my
keyboard in set 2, causes it to send shift-; on the wire.  In set 3,
it sends the single code for the colon key.

I wondered whether some users in this thread had keyboards like mine,
which seem to produce unusual results when you analyse the scancodes
coming from them.  It looks like mine is rarer than I thought :-).

> Below some remarks, maybe related.
>
> Some remarks on scancode sets live on
> http://www.win.tue.nl/~aeb/linux/kbd/scancodes-7.html
>
> Not all keyboards support all scancode sets. For example,
> my MyCom laptop only supports scancode Set 2, and its keyboard
> does not react at all when in mode 1 or 3. 
>
> The normal, default mode is translated scancode set 2.
> Putting keyboards in other modes is asking for trouble.

Agreed.  Unfortunately, it's impossible to use some of the keys in set
2 on mine :-).

John.
