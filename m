Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUCIHLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 02:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUCIHLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 02:11:37 -0500
Received: from is.magroup.ru ([213.33.179.242]:27927 "EHLO is.magroup.ru")
	by vger.kernel.org with ESMTP id S261503AbUCIHLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 02:11:36 -0500
Date: Tue, 9 Mar 2004 10:11:10 +0300
From: Antony Dovgal <tony2001@phpclub.net>
To: schierlm@gmx.de
Cc: schierlm-usenet@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: APM & device_power_up/down
Message-Id: <20040309101110.50b55786.tony2001@phpclub.net>
In-Reply-To: <S261722AbUCFWoa/20040306224430Z+905@vger.kernel.org>
References: <1uQOH-4Z1-9@gated-at.bofh.it>
	<S261722AbUCFWoa/20040306224430Z+905@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.10cvs2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2004 07:11:10.0828 (UTC) FILETIME=[B34012C0:01C405A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Mar 2004 23:44:08 +0100
Michael Schierl <schierlm-usenet@gmx.de> wrote:

> Hmm. Can you try unapplying it and applying the one in 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107506063605497&w=2
> instead? Does it work for you as well as with no patch?

Yes, it works ok for me with this patch.
 
> Where do you read something about powering down devices after suspend?
> The process is:
> 1- suspend devices
> 2- (power down devices w/ my patch)
> 3- asm call to put cpu in suspend mode - it will not return 
>    until you wake it up again
> 4- (power up devices w/ my patch)
> 5- resume devices

Err.. thanks for explaining..

---
WBR,
Antony Dovgal aka tony2001
tony2001@phpclub.net || antony@dovgal.com
