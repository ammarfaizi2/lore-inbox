Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318901AbSHEXP7>; Mon, 5 Aug 2002 19:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318914AbSHEXP7>; Mon, 5 Aug 2002 19:15:59 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:31716 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S318901AbSHEXP6>; Mon, 5 Aug 2002 19:15:58 -0400
Subject: Re: Patch: linux-2.5.30/fs/partitions/ldm.c BUG_ON(cond1 || cond2)
	separation
From: Richard Russon <ldm@flatcap.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020805140634.A2999@baldur.yggdrasil.com>
References: <20020805140634.A2999@baldur.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 06 Aug 2002 00:19:33 +0100
Message-Id: <1028589573.28848.10.camel@whiskey.something.uk.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

> 	linux-2.5.30/fs/partitions/ldm.c had 23 statements 
> of the form BUG_ON(condition1 || condition2).  This patch changes
> them to:
> 
> 		BUG_ON(condition1);
> 		BUG_ON(condition2);

Hmm...  The only reason I put the BUG_ONs in, is paranoia.  I cannot
imagine how they could be tripped, since all the pointers will have
already been checked.  If you wish to standardise the way BUG_ON is
used, then OK, change them.

> Could you please let me know if you want to handle submitting it

Please can you submit the patch to Linus.

Cheers,
  FlatCap (Rich)
  ldm@flatcap.org



