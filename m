Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbTBCQHf>; Mon, 3 Feb 2003 11:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbTBCQHf>; Mon, 3 Feb 2003 11:07:35 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:28435 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S266761AbTBCQHd>;
	Mon, 3 Feb 2003 11:07:33 -0500
Date: Mon, 3 Feb 2003 11:16:58 -0500
Message-Id: <200302031616.h13GGwwm005678@buggy.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: James Williams <fido@tcob1.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 3Comm 3CR990-TX-97 NIC
In-Reply-To: <3E3DF2A5.7060504@pobox.com>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
X-Spam-Flag: NO
X-Spam-Score: -1.9, 7 required, IN_REP_TO,QUOTED_EMAIL_TEXT,SIGNATURE_SHORT_DENSE,SPAM_PHRASE_01_02,USER_AGENT
X-Spam-Report: ---- Start SpamAssassin results
 
	-1.90 hits, 7 required;
 
	* -0.8 -- Found a In-Reply-To header
 
	* -0.5 -- Found a User-Agent header
 
	*  0.5 -- BODY: Spam phrases score is 01 to 02 (low)
 
	          [score: 1]
 
	* -0.8 -- BODY: Contains what looks like a quoted email text
 
	* -0.3 -- Short signature present (no empty lines)
 
	---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Feb 2003 23:40:05 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> There are two Linux drivers for it.  One is 3com's, a bit shoddy but Ion 
> B. did a nice job of cleaning it up.  The other is David Dillow's; DD's 
> driver looks really good, supports NAPI and all sorts of bells and whistles.
> 
> I'm currently waiting to see if DD's driver gets the stamp of approval 
> from a certain legal department.  If that doesn't come through soon, the 
> "backup plan" kicks into effect, and Ion's cleanup of 3com's driver gets 
> merged.

In the mean time, you can get my cleaned up version from
<http://www.badula.org/3c990/>. The 2.5 patch might not apply anymore
to the latest and greatest; let me know if that's indeed the case so
I can generate a new one.

> Neither driver hooks into the 2.5.x CryptoAPI, AFAIK...

Correct as far as the 3Com driver is concerned: it doesn't implement any
crypto stuff, I have no docs for it, and no free driver (OpenBSD in
particular) implements any of that stuff either.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
