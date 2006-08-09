Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWHIIU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWHIIU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWHIIU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:20:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51136
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965103AbWHIIU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:20:57 -0400
Date: Wed, 09 Aug 2006 01:20:45 -0700 (PDT)
Message-Id: <20060809.012045.21594448.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, netdev@vger.kernel.org,
       zach.brown@oracle.com
Subject: Re: [take6 0/3] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060809080754.GA29783@2ka.mipt.ru>
References: <11551105592821@2ka.mipt.ru>
	<20060809.005856.104034268.davem@davemloft.net>
	<20060809080754.GA29783@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Wed, 9 Aug 2006 12:07:57 +0400

> So you want to review kevent core only at the first point and postpone
> network AIO and the rest implementation after core is correct.

That's the idea

> Should I remove poll/timer notifications too?

That can stay
