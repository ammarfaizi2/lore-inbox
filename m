Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270244AbTGWM4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 08:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270248AbTGWM4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 08:56:53 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:63456 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S270244AbTGWM4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 08:56:52 -0400
From: root@mauve.demon.co.uk
Message-Id: <200307231310.OAA30193@mauve.demon.co.uk>
Subject: Re: 2.4.22-pre7: are security issues solved?
To: john@grabjohn.com (John Bradford)
Date: Wed, 23 Jul 2003 14:10:07 +0100 (BST)
Cc: davem@redhat.com, herbert@gondor.apana.org.au, a.marsman@aYniK.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200307231256.h6NCuEqX001509@81-2-122-30.bradfords.org.uk> from "John Bradford" at Jul 23, 2003 01:56:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > > If I know your password is 7 characters I have a smaller
> > > space of passwords to search to just brute-force it.
> >
> > It's much smaller if you didn't know that it was at most 7 characters
> > long.  However, if you did know the upper bound, or you were just
> > brute forcing all passwords starting from 1 character, then the
> > difference is relatively minor.  This is because
<snip>
> One time passwords are much more secure.

Nope.
Changing password to a password of similar complexity every 10 seconds
doesn't make it much less likely to be guessed than a static password.
It may mean you can't guess it again, but you generally don't want
an attacker to even log in once.

One-time passwords, using a key generator may be better for other 
reasons for example, more entropy than "31137" or other passwords that
users might pick, or be able to remember.

