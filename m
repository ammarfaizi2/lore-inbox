Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSKRBrt>; Sun, 17 Nov 2002 20:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSKRBrt>; Sun, 17 Nov 2002 20:47:49 -0500
Received: from almesberger.net ([63.105.73.239]:29457 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261322AbSKRBrs>; Sun, 17 Nov 2002 20:47:48 -0500
Date: Sun, 17 Nov 2002 20:32:13 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.47: strdup()
Message-ID: <20021117203213.K1407@almesberger.net>
References: <87d6p63ui2.fsf@goat.bogus.local> <3DD5E65A.59243812@digeo.com> <87y97t34hs.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y97t34hs.fsf@goat.bogus.local>; from olaf.dietsche#list.linux-kernel@t-online.de on Sat, Nov 16, 2002 at 04:42:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:
> +static inline char *strdup(const char *s) { return kstrdup(s, GFP_KERNEL); }

Why hide what's really going on ? Better change the callers to use
kstrdup.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
