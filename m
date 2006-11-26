Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935306AbWKZJ6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935306AbWKZJ6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 04:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935307AbWKZJ6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 04:58:37 -0500
Received: from mgw-ext12.nokia.com ([131.228.20.171]:44418 "EHLO
	mgw-ext12.nokia.com") by vger.kernel.org with ESMTP id S935306AbWKZJ6h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 04:58:37 -0500
Subject: Re: [RFC: 2.6 patch] remove the broken MTD_PCMCIA driver
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Simon Evans <spse@secret.org.uk>,
       linux-pcmcia@lists.infradead.org, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20061125191521.GD3702@stusta.de>
References: <20061125191521.GD3702@stusta.de>
Content-Type: text/plain; charset=utf-8
Date: Sun, 26 Nov 2006 11:40:13 +0200
Message-Id: <1164534013.576.24.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 26 Nov 2006 09:40:38.0832 (UTC) FILETIME=[EE60E300:01C7113E]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061126114123-1F261BB0-05057BA6/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-25 at 20:15 +0100, Adrian Bunk wrote:
> The MTD_PCMCIA driver has:
> - already been marked as BROKEN in 2.6.0 three years ago and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive this driver, the code is still
> present in the older kernel releases.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I've committed both patches to my git trees so David won't miss them.

http://git.infradead.org/?p=users/dedekind/dedekind-mtd-2.6.git;a=summary


-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)

