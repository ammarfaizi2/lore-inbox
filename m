Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUIKNnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUIKNnR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 09:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIKNnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 09:43:17 -0400
Received: from the-village.bc.nu ([81.2.110.252]:3507 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268153AbUIKNnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 09:43:16 -0400
Subject: Re: CPU Context corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4142DF44.7010900@lbsd.net>
References: <4142DF44.7010900@lbsd.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094906455.21088.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 13:40:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 12:19, Nigel Kukard wrote:
> What does this error mean?
> 
> 
> CPU 0: Machine Check Exception: 0000000000000004
> Bank 0: 820000001040080F
> 
> 
> I have a Matsonic 9097c motherboard, 2.4Ghz prescott celeron cpu. This 
> error seems to be random. We have replaced the motherboard & cpu to no 
> avail.

It normally indicates a hardware problem. The precise meaning of all the
bits is in the Intel chip docs (volume 3). If you've swapped the
mainboard/cpu it might just be bad RAM.

