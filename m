Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUAEI1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 03:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbUAEI1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 03:27:06 -0500
Received: from mail.mediaways.net ([193.189.224.113]:30817 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S265902AbUAEI1E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 03:27:04 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Soeren Sonnenburg <kernel@nn7.de>
To: szonyi calin <caszonyi@yahoo.com>
Cc: azarah@nosferatu.za.org, Con Kolivas <kernel@kolivas.org>,
       Willy Tarreau <willy@w.ods.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <20040104225827.39142.qmail@web40613.mail.yahoo.com>
References: <20040104225827.39142.qmail@web40613.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1073291218.3261.60.camel@localhost>
Mime-Version: 1.0
Date: Mon, 05 Jan 2004 09:26:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-04 at 23:58, szonyi calin wrote:
[...]
> how much free memory do you have when this happens ?
> I had 
> a similar problem. It was easily reproducive doing 
> a du -sh / and then trying to do other things.
> It didn't happend all the time but most of the time
> 
> Doing a 
> echo 16384 >/proc/sys/vm/min_free_kbytes
> seems to help the kernel remember that it has some swap and he
> *has* to use it in some cases

Hmmm... this machine has 1G memory and it happens after fresh
reboots.... so memory is not the issue.

Soeren.

