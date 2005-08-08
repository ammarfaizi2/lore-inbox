Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVHHQ0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVHHQ0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVHHQ0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:26:30 -0400
Received: from outmx018.isp.belgacom.be ([195.238.2.117]:37265 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932106AbVHHQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:26:30 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Timertop - update
Date: Mon, 8 Aug 2005 18:26:13 +0200
User-Agent: KMail/1.8.1
Cc: Daniel Petrini <d.pensator@gmail.com>, tony@atomide.com,
       Con Kolivas <kernel@kolivas.org>
References: <9268368b050808074579501f86@mail.gmail.com>
In-Reply-To: <9268368b050808074579501f86@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508081826.14298.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 August 2005 16:45, Daniel Petrini wrote:
> Hi,
>
> Here we have a slightly update for timertop script, it now shows the
> ticks in Hz (borrowed from Tony's pmstats - let me know if I shouldn't
>
> :-) ) and some cleanups.

Small comment: I had to move the shell call (#!/usr/bin/perl) to the top of 
the file before i was able to start it.

One that comes back very often in timertop is:

c0124cf0|    510606|   314.40| process_timeout

Any idea what that is?

Thanks,

Jan

-- 
One small step for man, one giant stumble for mankind.
