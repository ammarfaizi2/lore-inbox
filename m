Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161268AbVIPS5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbVIPS5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161267AbVIPS5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:57:38 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:50561 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161266AbVIPS5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:57:37 -0400
Date: Fri, 16 Sep 2005 20:57:31 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: 7eggert@gmx.de,
       =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
In-Reply-To: <432B0A47.7060909@zytor.com>
Message-ID: <Pine.LNX.4.58.0509162029470.5708@be1.lrz>
References: <4N6EL-4Hq-3@gated-at.bofh.it> <4N6EL-4Hq-5@gated-at.bofh.it>
 <4N6EK-4Hq-1@gated-at.bofh.it> <4N6EX-4Hq-27@gated-at.bofh.it>
 <4N6Ox-4Ts-33@gated-at.bofh.it> <4N7AS-67L-3@gated-at.bofh.it>
 <E1EGKXl-0001Sn-GA@be1.lrz> <432B0A47.7060909@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, H. Peter Anvin wrote:
> Bodo Eggert wrote:

> > What's supposed to happen if you concatenate a script from your french
> > user and from your russian user, both using localized text, into one file?
> > Unless you can guarantee every editor to correctly handle this case, all
> > usage of 8-bit-characters should be disabled - NOT!
> 
> Actually, it's quite easy to avoid problems by using UTF-8 consistently. 
>    The 8-bit characters are oddballs and need to be treated specially, 
> but look, guys, it's 2005 - UTF-8 should be the norm, not the exception.

It should, but as long as old programs are still around, we'll have both 
and need a marker to distinguish them. Otherwise we'll be stuck with
legacy scripts for a long time.

-- 
I'm a member of DNA (National Assocciation of Dyslexics).
	-- Storm in <5Z4Z7.52353$4x4.6445347@news2-win.server.ntlworld.com>
