Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279865AbRKVP2l>; Thu, 22 Nov 2001 10:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279842AbRKVP2b>; Thu, 22 Nov 2001 10:28:31 -0500
Received: from ns.suse.de ([213.95.15.193]:20236 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279865AbRKVP2R>;
	Thu, 22 Nov 2001 10:28:17 -0500
To: Phil Howard <phil-linux-kernel@ipal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EINTR vs ERESTARTSYS, ERESTARTSYS not defined
In-Reply-To: <20011122083623.A18057@vega.ipal.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Nov 2001 16:28:16 +0100
In-Reply-To: Phil Howard's message of "22 Nov 2001 15:40:26 +0100"
Message-ID: <p73pu6ax1tb.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Howard <phil-linux-kernel@ipal.net> writes:

> | 
> | /* Should never be seen by user programs */

This applies to user programs, but not to strace. Try it: the actual user
program doesn't see them. strace is not a ordinary user program here.


-Andi

