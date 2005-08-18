Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVHRTty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVHRTty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 15:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVHRTty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 15:49:54 -0400
Received: from mailfe02.tele2.fr ([212.247.154.44]:16542 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932390AbVHRTtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 15:49:53 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Thu, 18 Aug 2005 21:49:41 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: idle task's task_t allocation on NUMA machines
Message-ID: <20050818194941.GH8822@bouh.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <20050818140829.GB8123@implementation.labri.fr> <4304A6DF.6040703@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4304A6DF.6040703@cosmosbay.com>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet, le Thu 18 Aug 2005 17:18:55 +0200, a écrit :
> I believe IRQ stacks are also allocated on node 0, that seems more serious.

For the i386 architecture at least, yes: they are statically defined in
arch/i386/kernel/irq.c, while they could be per_cpu.

Regards,
Samuel
