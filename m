Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbSKLMqo>; Tue, 12 Nov 2002 07:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266729AbSKLMqo>; Tue, 12 Nov 2002 07:46:44 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:16545 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266721AbSKLMqn> convert rfc822-to-8bit; Tue, 12 Nov 2002 07:46:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
Subject: Re: devfs
Date: Tue, 12 Nov 2002 13:51:08 +0100
User-Agent: KMail/1.4.3
References: <20021112093259.3d770f6e.spyro@f2s.com> <20021112094949.GE17478@higherplane.net> <6uadkf9kdt.fsf@zork.zork.net>
In-Reply-To: <6uadkf9kdt.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211121351.08328.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually, here's a question: are /sbin/hotplug upcalls serialized in
> some fashion?  I'd hate to online a thousand devices in my disk array
> and have the machine forkbomb itself.

Nope, no serialisation. You don't have any guarantee even that
addition will be delivered before removal.

	Regards
		Oliver

