Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTKZRmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTKZRmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:42:04 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:54913
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264269AbTKZRl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:41:59 -0500
Date: Wed, 26 Nov 2003 12:40:43 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Vince <fuzzy77@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
In-Reply-To: <3FC4E42A.40906@free.fr>
Message-ID: <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com>
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>
 <3FC4E42A.40906@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Vince wrote:

> parameter LOG_BUF_LEN. Some people required 32 kB. But you shouldn't
> exceed 60 kB since the dump is done in real mode (16 bits).
> For kernel versions 2.5.6x and later, the LOG_BUF_LEN parameter is part
> of the kernel .config file (LOG_BUF_SHIFT) so you don't need to modify
> it at all.
> ---------------------------------
>
> ...so I you think 60kB would be enough to catch the first oops -- or if
> the doc is outdated -- I can try this...

*groan* do you have a PDA?

