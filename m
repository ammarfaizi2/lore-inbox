Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270243AbTGWMd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 08:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270244AbTGWMd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 08:33:28 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5762 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270243AbTGWMd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 08:33:26 -0400
Date: Wed, 23 Jul 2003 13:56:14 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307231256.h6NCuEqX001509@81-2-122-30.bradfords.org.uk>
To: davem@redhat.com, herbert@gondor.apana.org.au
Subject: Re: 2.4.22-pre7: are security issues solved?
Cc: a.marsman@aYniK.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If I know your password is 7 characters I have a smaller
> > space of passwords to search to just brute-force it.
>
> It's much smaller if you didn't know that it was at most 7 characters
> long.  However, if you did know the upper bound, or you were just
> brute forcing all passwords starting from 1 character, then the
> difference is relatively minor.  This is because
>
> n + n^2 + n^3 + n^4 + n^5 + n^6
>
> is much smaller than n^7 where n is something like 62 for a reasonable
> password.
>
> So if your password was broken using this method, then it's probably
> too short anyway.

One time passwords are much more secure.

John.
