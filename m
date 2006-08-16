Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWHPTpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWHPTpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWHPTpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:45:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60869
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932112AbWHPTpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:45:54 -0400
Date: Wed, 16 Aug 2006 12:45:54 -0700 (PDT)
Message-Id: <20060816.124554.18301763.davem@davemloft.net>
To: zach.brown@oracle.com
Cc: johnpol@2ka.mipt.ru, hch@infradead.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org
Subject: Re: [take9 1/2] kevent: Core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <44E35F29.8010500@oracle.com>
References: <20060816134550.GA12345@infradead.org>
	<20060816135642.GD4314@2ka.mipt.ru>
	<44E35F29.8010500@oracle.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zach Brown <zach.brown@oracle.com>
Date: Wed, 16 Aug 2006 11:08:41 -0700

> >>> +	for (i=0; i<ARRAY_SIZE(u->kevent_list); ++i)
> >> 	for (i = 0; i < ARRAY_SIZE(u->kevent_list); i++)
> > 
> > Ugh, no. It reduces readability due to exessive number of spaces.
> 
> Ihavetoverystronglydisagree.

Metoo. :-)

Spaces help humans parse out the syntactic structure of
multi-token expressions.
