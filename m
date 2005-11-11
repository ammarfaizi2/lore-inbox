Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVKKPdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVKKPdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVKKPdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:33:33 -0500
Received: from mail.linicks.net ([217.204.244.146]:732 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750817AbVKKPdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:33:32 -0500
From: Nick Warne <nick@linicks.net>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 14/15] misc: Configurable number of supported IDE interfaces
Date: Fri, 11 Nov 2005 15:33:13 +0000
User-Agent: KMail/1.8.1
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511111533.13474.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> You are duplicating functionality of CONFIG_IDE_MAX_HWIFS,
> please find a way to use it for EMBEDDED.
> 
> Also please cc: linux-ide on IDE related patches.
> 
> On 11/11/05, Matt Mackall <mpm@selenic.com> wrote:
>> Configurable number of supported IDE interfaces
>>
>> This overrides the default limit (which may be set per arch with
>> CONFIG_IDE_MAX_HWIFS). This is the result of setting interfaces to 1:

This is very similar to my unaccepted patch a few months ago:

http://lkml.org/lkml/2005/6/25/69

Nick
-- 
http://sourceforge.net/projects/quake2plus

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

