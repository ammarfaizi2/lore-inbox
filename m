Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUCKSV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbUCKSV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:21:27 -0500
Received: from host199.200-117-131.telecom.net.ar ([200.117.131.199]:265 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S261631AbUCKSUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:20:13 -0500
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm1
Date: Thu, 11 Mar 2004 15:22:26 -0300
User-Agent: KMail/1.6.2
Cc: lkml@metanurb.dk, linux-kernel@vger.kernel.org
References: <20040310233140.3ce99610.akpm@osdl.org> <200403111453.20866.norberto+linux-kernel@bensa.ath.cx> <20040311100957.00dd6e7f.akpm@osdl.org>
In-Reply-To: <20040311100957.00dd6e7f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403111522.26331.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:
> > Redeeman wrote:
> >  > hey andrew, i have a problem with this kernel, when it boots, it lists
> >  > vp_ide and stuff, and then suddenly after that my screen gets flodded
> >
> >  Same here. bad: scheduling while atomic. .config attached (no dmesg as I
> > have no experience with serial consoles yet.)
>
> Did you remove the spin_unlock_irq() from the end of mpage_writepages()?

Done now.

$ uname -a
Linux venkman 2.6.4-mm1 #2 Thu Mar 11 15:18:21 ART 2004 i686 Pentium III 
(Coppermine) GenuineIntel GNU/Linux


Thanks Andrew!

Norberto
