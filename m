Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317920AbSGKWQe>; Thu, 11 Jul 2002 18:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317921AbSGKWQd>; Thu, 11 Jul 2002 18:16:33 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:24964 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317920AbSGKWQc> convert rfc822-to-8bit; Thu, 11 Jul 2002 18:16:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Date: Fri, 12 Jul 2002 00:21:15 +0200
User-Agent: KMail/1.4.1
Cc: mc@cs.Stanford.EDU
References: <200207112135.OAA03801@csl.Stanford.EDU>
In-Reply-To: <200207112135.OAA03801@csl.Stanford.EDU>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207120021.15817.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. Juli 2002 23:35 schrieb Dawson Engler:
> Hi All,
>
> enclosed is an error log for a checker that warns when a lock/disable
> was not paired with an unlock/enable.  These errors could be tricky,
> and they only got a quick inspection, so treat the reports as potential
> rather than guaranteed bugs.
>
> Run over 2.5.8 it found 56 potential errors.
>
> Dawson

Hi,

I checked the USB ones. Two current bugs were found. In one other case
has been heavily updated. In one case the cker was wrong, it seems to have
trouble with goto and the other cases had already been fixed.

	Regards
		Oliver

