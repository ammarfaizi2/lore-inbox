Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270066AbUJHRX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbUJHRX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270069AbUJHRX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:23:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:10165 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270066AbUJHRXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:23:51 -0400
Subject: Re: [PATCH] protect against buggy drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linus@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097254421.16787.27.camel@localhost.localdomain>
References: <1097254421.16787.27.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097252477.2528.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 08 Oct 2004 17:21:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-08 at 17:53, Stephen Hemminger wrote:
> # fs/char_dev.c
> #   2004/10/08 09:51:52-07:00 shemminger@zqx3.pdx.osdl.net +5 -0
> #   Protect against bad driver writers who pass invalid names when
> #   setting up character devices.
> # 

And how many badly mannered people check the return on this ?
Shouldn't it just BUG() ?


