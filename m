Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318928AbSHSQ0t>; Mon, 19 Aug 2002 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318930AbSHSQ0t>; Mon, 19 Aug 2002 12:26:49 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:15286 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318928AbSHSQ0s> convert rfc822-to-8bit; Mon, 19 Aug 2002 12:26:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Marco Colombo <marco@esi.it>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Date: Mon, 19 Aug 2002 18:29:52 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208191711500.26653-100000@Megathlon.ESI>
In-Reply-To: <Pine.LNX.4.44.0208191711500.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208191829.52241.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Not at all. Let me (one process) read 1MB from /dev/urandom,
> and analyze it. If I can break SHA-1, I'm able to predict *future*
> /dev/urandom output, expecially if I keep draining bits from
> /dev/random.

True, but you cannot predict which task will read which part
of the output of urandom.
Also not all attackers can read from urandom.

If you really care, you might implement entropy pools
per user.

	Regards
		Oliver

