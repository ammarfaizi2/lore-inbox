Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266564AbUHBPvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266564AbUHBPvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266565AbUHBPvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:51:02 -0400
Received: from jade.spiritone.com ([216.99.193.136]:15515 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266564AbUHBPvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:51:00 -0400
Date: Mon, 02 Aug 2004 08:50:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: finding out the boot cpu number from userspace
Message-ID: <12690000.1091461852@[10.10.2.4]>
In-Reply-To: <20040802121635.GE14477@devserv.devel.redhat.com>
References: <20040802121635.GE14477@devserv.devel.redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> assuming cpu 0 is the boot cpu sounds fragile/incorrect, but for irqbalanced
> I'd like to find out which cpu is the boot cpu, is there a good way of doing
> so ?
> 
> The reason for needing this is that some firmware only likes running on the
> boot cpu so I need to bind firmware-related irq's to that cpu ideally.

On any sane arch, cpu 0 *IS* always the boot CPU, as we dynamically number
CPUs that way ... that doesn't mean that it's apicid 0. I believe that 
PPC64 screwed this up, but AFAIK, everyone else gets it correct ... ;-)

M.

