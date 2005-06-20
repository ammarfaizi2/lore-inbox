Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVFTTeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVFTTeB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVFTTd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:33:56 -0400
Received: from mail.linicks.net ([217.204.244.146]:25861 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261532AbVFTTcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:32:33 -0400
From: Nick Warne <nick@linicks.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: 2.6.12 udev hangs at boot
Date: Mon, 20 Jun 2005 20:32:30 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200506181332.25287.nick@linicks.net> <200506202000.08114.nick@linicks.net> <20050620192118.GA13586@suse.de>
In-Reply-To: <20050620192118.GA13586@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506202032.30771.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 20:21, Greg KH wrote:

> > It appears the issue people are seeing is with Slack 10, which shipped
> > with udev 0.26 - and I presume there was 'custom' rules Patrick had built
> > in.
>
> Ick.  Hm, there's not been any updates for slack since then? (note,
> there was no 0.26 release, there are no '.' in udev releases.)
>
> Any Slackware users want to pester them for updates?

Remember this is Slackware 10 here I am talking about - Slackware 10.1 has 
been released since, that uses as stock udev 50.  Slackware current uses udev 
54.  Trouble is here also, GLIBC has been updated in latest Slackware[s], so 
there is no real upgrade path for Slack 10 users other than the whole 
caboodle - which breaks a lot if you have all the latest 'other stuff' built 
from source anyway.

I guess many users don't upgrade all the system like I do to find these 
problems.  This appears to be just a gotcha for old Slackware 10 users like 
me.  Sometimes you read stuff about doing an upgrade, and unless it pokes yer 
eye out with a big stick you miss it... so it is isn't a big deal as long as 
people know about it - it's an easy fix.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
