Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbVKIVHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbVKIVHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbVKIVHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:07:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31880
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1160998AbVKIVHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:07:14 -0500
Date: Wed, 09 Nov 2005 13:07:13 -0800 (PST)
Message-Id: <20051109.130713.06900332.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: fix sparse warning in horizon atm driver.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051109055739.GA630@redhat.com>
References: <20051109055739.GA630@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Wed, 9 Nov 2005 00:57:39 -0500

> these vars get fed u32's, and are OR'd with u32's.
> Chances are they were meant to be u32's.
> 
> I don't have hardware to test this, but I can't fathom
> why a u16 would be used here.
> 
> drivers/atm/horizon.c:1564:12: warning: cast truncates bits from constant value (40000000 becomes 0)

Hmmm... I would merge this directly, but I'd like Chas Williams
(the ATM maintainer) to glance it over first.  Can you forward
it to him (CC:'ing the linux-atm list, also mentioned in MAINTAINERS,
of course)?  Thanks.
