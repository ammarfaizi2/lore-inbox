Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263598AbRFAQ0i>; Fri, 1 Jun 2001 12:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263603AbRFAQ03>; Fri, 1 Jun 2001 12:26:29 -0400
Received: from [216.151.155.121] ([216.151.155.121]:22277 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S263598AbRFAQ0K>; Fri, 1 Jun 2001 12:26:10 -0400
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [newbie] NFS broken in 2.4.4?
In-Reply-To: <Pine.LNX.4.31.0106011808310.13429-100000@pc40.e18.physik.tu-muenchen.de>
From: Doug McNaught <doug@wireboard.com>
Date: 01 Jun 2001 12:25:03 -0400
In-Reply-To: Roland Kuhn's message of "Fri, 1 Jun 2001 18:17:28 +0200 (CEST)"
Message-ID: <m3wv6w417k.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de> writes:

> Hi folks!
> 
> When a process tries to lstat64 a file on nfs and the reply is not
> received it gets blocked forever. Should it be that way?

If it's a hard nfs mount, yes.  Mount soft if you want timeouts.

-Doug
-- 
The rain man gave me two cures; he said jump right in,
The first was Texas medicine--the second was just railroad gin,
And like a fool I mixed them, and it strangled up my mind,
Now people just get uglier, and I got no sense of time...          --Dylan
