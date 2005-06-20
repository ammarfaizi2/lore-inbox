Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVFTKyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVFTKyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVFTKyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:54:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16291 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261188AbVFTKyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:54:32 -0400
Date: Mon, 20 Jun 2005 12:54:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
In-Reply-To: <42B6B733.24349.B0B7F9@rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0506201242190.3728@scrub.home>
References: <42B685E8.9359.14B98F19@rkdvmks1.ngate.uni-regensburg.de>
 <42B6B733.24349.B0B7F9@rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Jun 2005, Ulrich Windl wrote:

> it seems you don't like the patch for some personal reasons, and now your are 
> trying to find arguments against it.

Please stop trying such mind reading tricks.

> > fix it first, if the current system is a mess clean it up first, but 
> > don't mix these two steps, unless you want to introduce more broken mess.
> 
> If you introduce something new (higher resolution clock), you should start with 
> something clean. Just hacking it in the first attempt, anf then making it 
> beautiful in a second attempt is a waste of time IMHO.

Well, I'm not really convinced of the quality of the patch, if nobody can 
explain it to me and I don't think my questions were that unreasonable.
We are talking about a core subsystem here, which IMO justifies a little 
more care. Maybe you should follow the fs development a bit for an example 
how to do even large changes in relatively simple steps.

bye, Roman
