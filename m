Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268890AbTBZSiW>; Wed, 26 Feb 2003 13:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268891AbTBZSiV>; Wed, 26 Feb 2003 13:38:21 -0500
Received: from mail.coastside.net ([207.213.212.6]:41697 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S268890AbTBZSiU>; Wed, 26 Feb 2003 13:38:20 -0500
Mime-Version: 1.0
Message-Id: <p05210508ba82bc0ea504@[207.213.214.37]>
In-Reply-To: <200302261803.h1QI3BT24020@devserv.devel.redhat.com>
References: <200302261803.h1QI3BT24020@devserv.devel.redhat.com>
Date: Wed, 26 Feb 2003 10:47:52 -0800
To: Alan Cox <alan@redhat.com>, kimball@serverworks.com (Kimball Brown)
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Tighten up serverworks workaround.
Cc: alan@redhat.com (Alan Cox), davej@codemonkey.org.uk,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:03pm -0500 2/26/03, Alan Cox wrote:
>  > How can e help?  Please give me a configuration and how the bug manifests
>>  inself.
>
>OSB4 chipset system, some memory areas marked write combining with the
>processor memory type range registers. A long time ago Dell (I
>think) reported corruption from this and submitted changes to block the
>use of write combining on OSB4. The question has arisen as to whether
>thats a known thing, and if so which release of the chipset fixed it so that
>people can only apply such a restriction to problem cases not all OSB4.

Presumably we're talking about CNB30 (the north bridge) rather than 
OSB4 (the south bridge).
-- 
/Jonathan Lundell.
