Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbQKVKAa>; Wed, 22 Nov 2000 05:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQKVKAJ>; Wed, 22 Nov 2000 05:00:09 -0500
Received: from mail.zmailer.org ([194.252.70.162]:14349 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129906AbQKVKAG>;
	Wed, 22 Nov 2000 05:00:06 -0500
Date: Wed, 22 Nov 2000 11:29:52 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: 64738 <schwung@rumms.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel bits
Message-ID: <20001122112952.Y28963@mea-ext.zmailer.org>
In-Reply-To: <974881546.3a1b830ae5202@rumms.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974881546.3a1b830ae5202@rumms.uni-mannheim.de>; from schwung@rumms.uni-mannheim.de on Wed, Nov 22, 2000 at 09:25:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 09:25:46AM +0100, 64738 wrote:
> Hi.
> 
> Is there a syscall or something that can tell me whether I'm working on a 32- 
> or a 64-bit kernel?

	uname(2)

	It gives out various strings from which you must then deduce,
	what kind of kernel is needed to run at what kind of machine.

	And even though the machine is running with 64-bit kernel
	(e.g. alpha/sparc64/mips64/ia64), your userspace code might
	be running in 32-bit mode.

> Greeting,
>  Alain
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
