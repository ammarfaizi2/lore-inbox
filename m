Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270248AbTGWNpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270324AbTGWNpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:45:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4992 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270248AbTGWNpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:45:34 -0400
Date: Wed, 23 Jul 2003 15:08:57 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307231408.h6NE8vCV000217@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, root@mauve.demon.co.uk
Subject: Re: 2.4.22-pre7: are security issues solved?
Cc: a.marsman@aYniK.com, alan@lxorguk.ukuu.org.uk, davem@redhat.com,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > If I know your password is 7 characters I have a smaller
> > > > space of passwords to search to just brute-force it.
> > >
> > > It's much smaller if you didn't know that it was at most 7 characters
> > > long.  However, if you did know the upper bound, or you were just
> > > brute forcing all passwords starting from 1 character, then the
> > > difference is relatively minor.  This is because
> <snip>
> > One time passwords are much more secure.
>
> Nope.
> Changing password to a password of similar complexity every 10 seconds
> doesn't make it much less likely to be guessed than a static password.

For the attack in question, it does, as long as no two consecutive
passwords have the same number of characters.

For example, if the list of OTPs is:

alpha
beta
epsilon

The user logs in using the first password, and somebody logs that it
has five characters.  The next valid password, (the only valid one),
has four.

John.
