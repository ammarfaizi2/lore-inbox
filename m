Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281306AbRKLHqd>; Mon, 12 Nov 2001 02:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281302AbRKLHqY>; Mon, 12 Nov 2001 02:46:24 -0500
Received: from lowland.webflex.nl ([212.72.61.81]:33697 "EHLO mail.webflex.nl")
	by vger.kernel.org with ESMTP id <S281301AbRKLHqP>;
	Mon, 12 Nov 2001 02:46:15 -0500
Date: Mon, 12 Nov 2001 08:46:08 +0100 (CET)
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: Momchil Velikov <velco@fadata.bg>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix loop with disabled tasklets
In-Reply-To: <87hes1qp21.fsf@fadata.bg>
Message-ID: <Pine.BSI.4.05L.10111120843291.9564-100000@utopia.knoware.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 11 Nov 2001, Momchil Velikov wrote:
> You may want to have a look at the following patches (tested by visual
> inspection):

I like this one. I think it is what Andrea was going for, without the 
changes to interrupt.h. If we are going for thisone we should add some
comments to interrupt.h warning about deadlocks etc.

still working on a patch that adds a cpu field to the tasklet_struct.
Looking for races takes me a long time :).

	me


