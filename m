Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTGAKaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTGAKaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:30:08 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:51334 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261874AbTGAKaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:30:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Luis Miguel Garcia <ktech@wanadoo.es>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O1int 0307010922 for 2.5.73 interactivity
Date: Tue, 1 Jul 2003 20:48:02 +1000
User-Agent: KMail/1.5.2
References: <20030701133241.58d17db0.ktech@wanadoo.es>
In-Reply-To: <20030701133241.58d17db0.ktech@wanadoo.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307012048.02612.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003 21:32, Luis Miguel Garcia wrote:
> Con, I want to give you Lots of Thanks for the work you're doing with the
> O1int patches.

Thanks. Hopefully it will all be worthwhile.

> Don't you think that we need an option in the kernel to select if we want a
> Server Kernel or a Desktop Kernel?
>
> With the first one, only throughput is important and in the second one, we
> can take in all the stuff to improve the interactivity (preempt, 01int,
> granularity) so we can give more agresive interactivity to the Desktop
> Kernel.

A properly tuned scheduler should work in all settings. The granularity patch 
is the only one which would only benefit the desktop but I'm hoping to make 
it unnecessary for this patch to be used.

Con

