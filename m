Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUFPSGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUFPSGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUFPSGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:06:16 -0400
Received: from werewolf.schneelocke.net ([62.8.212.6]:54825 "EHLO
	werewolf.schneelocke.net") by vger.kernel.org with ESMTP
	id S264377AbUFPSDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:03:31 -0400
Date: Wed, 16 Jun 2004 19:59:02 +0200
From: lkml@gl00on.net
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Programtically tell diff between HT and real
Message-ID: <20040616175902.GC12094@werewolf.schneelocke.net>
References: <20040616174646.70010.qmail@web51805.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616174646.70010.qmail@web51805.mail.yahoo.com>
X-Face: "/lf:;F?1M2u`>bt]h&FhSRZ"hM>a_b!7A;I1Lc!rWw'INc+S-NYk<I%I(qa022%$mEk'8v2DDinL*7g_?Z`d+cnKut<JfZ,TYTI&KrBTM-?({z<=M221B=!b@'PI5~nv:%F7xeFxBBY!6l5b+Gu:NX&7@.k474ZfXn*|?j^6s"E]&7nRc0M}X92&=8FXi)#'<uUij+4#S:c]>|&?>I2.KiJMku(vOc0|'VK#FGE5:F~+BwY$Ddi)?fp[&xy/89jGCVnS/[aN-[Z0bGuM./UD}3*c5AbucK=l!8(&^4=\qH}_(M]r`t3:_OjYFu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a way to tell the difference between normal
> processors and HT enabled processors?  That is, does
> the linux kernel know the difference and is there a
> way to to know the difference.

Execute the CPUID instruction with EAX=00000001h. I think HT-enabled cpus
should have bit 28 of the value returned in EDX set.

-- 
 7:57PM  up 134 days,  5:11, 1 user, load averages: 0.16, 0.18, 0.16

Every non-empty totally disconnected perfect compact metric space is
homeomorphic to the Cantor set.
