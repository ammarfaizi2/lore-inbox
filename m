Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264563AbRFTSss>; Wed, 20 Jun 2001 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264565AbRFTSsi>; Wed, 20 Jun 2001 14:48:38 -0400
Received: from inway98.cdi.cz ([213.151.81.98]:53499 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S264563AbRFTSs1>;
	Wed, 20 Jun 2001 14:48:27 -0400
Posted-Date: Wed, 20 Jun 2001 20:48:11 +0200
Date: Wed, 20 Jun 2001 20:48:11 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: bert hubert <ahu@ds9a.nl>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Threads are processes that share more
In-Reply-To: <20010620175937.A8159@home.ds9a.nl>
Message-ID: <Pine.LNX.4.10.10106202036470.10363-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                     Threads are processes that share more

BTW is not possible to implement threads as subset of process ?
Like thread list pointed to from task_struct. It'd contain
thread_structs plus another scheduler's data.
The thread could be much smaller than process.

Probably there is another problem I don't see, I'm just
currious whether can it work like this ..

devik

