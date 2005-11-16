Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbVKPTv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbVKPTv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbVKPTv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:51:26 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36790
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030449AbVKPTv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:51:26 -0500
Date: Wed, 16 Nov 2005 11:51:41 -0800 (PST)
Message-Id: <20051116.115141.33136176.davem@davemloft.net>
To: david@pleyades.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: /net/sched/Kconfig broken
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051116194414.GA14953@fargo>
References: <20051116194414.GA14953@fargo>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Gómez <david@pleyades.net>
Date: Wed, 16 Nov 2005 20:44:14 +0100

> It's impossible to enable the U32 classifier in QoS submenu, to use it
> with the "tc" application. In fact there are 23 :-/ options and suboptions
> that are missing from the configuration because it seems that the Kconfig
> file is broken.

I can enable this just fine by using "make config", making
sure to enable CONFIG_NET_SCHED, then CONFIG_NET_CLS_BASIC,
and then the necessary classifiers (including U32) are offered
to be enabled.

Perhaps there is something amiss in the configuration mechanism
you are trying to use.  So you might want to tell us which kernel
config menu program you are trying to use so this can be debugged
further.
