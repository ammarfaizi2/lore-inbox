Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316843AbSF0NSA>; Thu, 27 Jun 2002 09:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSF0NR7>; Thu, 27 Jun 2002 09:17:59 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:59397 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S316843AbSF0NR7>; Thu, 27 Jun 2002 09:17:59 -0400
Date: Thu, 27 Jun 2002 14:17:42 +0100 (BST)
From: David Woodhouse <dwmw2@infradead.org>
X-X-Sender: dwmw2@imladris.demon.co.uk
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Nicolas Bougues <nbougues-listes@axialys.net>,
       Andries Brouwer <aebr@win.tue.nl>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020627073831.4174A-101000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0206271415260.20792-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Subject: Re: Problems with wait queues 
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2002, Richard B. Johnson wrote:

> Attached is a file showing about 485 usages of 'sleep_on' in the
> kernel drivers. If this usage is, as you say, buggy then will you
> please inform us unwashed hordes what we should use to replace these?

Anything you like -- as long as it doesn't have gaping races which are 
obvious to anyone with half a clue who actually _thinks_ about the code 
rather than assuming that _driver_ authors all got it right :)

We _really_ need to kill sleep_on() in 2.5. 

-- 
dwmw2


