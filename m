Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKVK4X>; Wed, 22 Nov 2000 05:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQKVK4N>; Wed, 22 Nov 2000 05:56:13 -0500
Received: from mail.zmailer.org ([194.252.70.162]:19725 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129150AbQKVKzy>;
	Wed, 22 Nov 2000 05:55:54 -0500
Date: Wed, 22 Nov 2000 12:25:43 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: dhinds@zen.stanford.edu, torvalds@transmeta.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules
Message-ID: <20001122122543.A28963@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0011212328570.30344-100000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011212328570.30344-100000@svea.tellus>; from tori@tellus.mine.nu on Tue, Nov 21, 2000 at 11:34:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 11:34:45PM +0100, Tobias Ringstrom wrote:
> The subject says it all. Is there any particular (technical) reason
> why I must have both the generic pcmcia code and the controller support
> built-in, or build all of them as modules?
> 
> /Tobias

Wasn't there some strange laptop model which had PCMCIA floppy/CDROM,
which are unavailable to bootstrap process, unless PCMCIA is supported
at the booting kernel ?

Or was it about USB floppy at some other laptop?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
