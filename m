Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbSLaAsz>; Mon, 30 Dec 2002 19:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbSLaAsz>; Mon, 30 Dec 2002 19:48:55 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:39905 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267103AbSLaAsy> convert rfc822-to-8bit; Mon, 30 Dec 2002 19:48:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Manfred Spraul <manfred@colorfullife.com>,
       Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: question on context of kfree_skb()
Date: Tue, 31 Dec 2002 01:57:06 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <3E10C991.4060807@colorfullife.com>
In-Reply-To: <3E10C991.4060807@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212310157.06624.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 30. Dezember 2002 23:32 schrieb Manfred Spraul:
> Mulix wrote:
> >dev_kfree_skb_any() should be called when you could be either
> >executing in interrupt context or not.
>
> dev_kfree_skb_any() can misdetect the context: You must not use the
> function if you hold an irq spinlock and you might be running from BH or
> process context.

What then shall be used under these circumstances ?
Could you perhaps summarise the issue ?

	Regards
		Oliver

