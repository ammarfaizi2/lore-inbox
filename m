Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280789AbRKOJGQ>; Thu, 15 Nov 2001 04:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280787AbRKOJF4>; Thu, 15 Nov 2001 04:05:56 -0500
Received: from ebola.baana.suomi.net ([213.139.166.70]:33798 "EHLO
	ebola.baana.suomi.net") by vger.kernel.org with ESMTP
	id <S280786AbRKOJFr>; Thu, 15 Nov 2001 04:05:47 -0500
Date: Thu, 15 Nov 2001 11:05:44 +0200 (EET)
From: janne <sniff@xxx.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <Pine.LNX.4.10.10111150947400.16975-200000@ebola.baana.suomi.net>
Message-ID: <Pine.LNX.4.10.10111151104360.17267-100000@ebola.baana.suomi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to followup to my previous post: i don't know how the current code
works, but perhaps there should be some logic added to check the
percentage of total mem used for cache before swapping out.

like, if memory is full and there's less than 10% of total mem used for
cache, then start swapping out. not if ~90% is already used for cache.. :)

