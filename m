Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbVHXTzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbVHXTzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbVHXTzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:55:38 -0400
Received: from mail1.kontent.de ([81.88.34.36]:37795 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751505AbVHXTzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:55:37 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: question on memory barrier
Date: Wed, 24 Aug 2005 21:55:34 +0200
User-Agent: KMail/1.8
Cc: "moreau francis" <francis_moreau2000@yahoo.fr>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com> <200508242132.52730.oliver@neukum.org> <Pine.LNX.4.61.0508241542110.31690@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0508241542110.31690@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242155.34837.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And you never even bothered to read what I said about that???
> The write ORDER will NOT change. Period. It's a FIFO. Writes

On current implementations of i386. That is not good enough.
We want code that works everywhere. You are wrong.
If you need to have ordered writes to a bus, use wmb().

	Regards
		Oliver
