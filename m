Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWAYSlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWAYSlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWAYSlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:41:49 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:40426 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S932068AbWAYSls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:41:48 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] bttv: correct bttv_risc_packed buffer size
To: Duncan Sands <duncan.sands@math.u-psud.fr>, mchehab@brturbo.com.br,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Wed, 25 Jan 2006 19:37:59 +0100
References: <5yQ4M-7PJ-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F1pWq-0001d1-JH@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

> This patch fixes the strange crashes I was seeing after using
> my bttv card to watch television.  They were caused by a
> buffer overflow in bttv_risc_packed.

<snip>

Would these errors e.g. cause a corruption of exactly four bytes at the start
of random pages?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
