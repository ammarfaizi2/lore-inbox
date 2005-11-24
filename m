Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbVKXWf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbVKXWf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 17:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbVKXWf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 17:35:29 -0500
Received: from mail.linicks.net ([217.204.244.146]:42136 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932666AbVKXWf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 17:35:28 -0500
From: Nick Warne <nick@linicks.net>
To: Norbert van Nobelen <Norbert@hipersonik.com>
Subject: Re: [OT] 1500 days uptime.
Date: Thu, 24 Nov 2005 22:35:23 +0000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200511242147.45248.nick@linicks.net> <200511242332.13556.Norbert@hipersonik.com>
In-Reply-To: <200511242332.13556.Norbert@hipersonik.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511242235.23724.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 22:32, Norbert van Nobelen wrote:
> great uptime. I have 3 readhat boxes who are now more than 1 year up, but
> bizar enough reset the uptime (command uptime) back to zero and started
> counting over again.

Hi Norbert,

Yes, uptime 'wraps' at about 493 days or something.

use:

last -xf /var/run/utmp runlevel

to get last change to run level (run level at boot, presumably).  This was 
posted on LKML ages ago where I learnt to use it to get true 'uptime'.

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
My quake2 project:
http://sourceforge.net/projects/quake2plus/
