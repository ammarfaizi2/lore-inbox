Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSDCXfa>; Wed, 3 Apr 2002 18:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSDCXfV>; Wed, 3 Apr 2002 18:35:21 -0500
Received: from ns.suse.de ([213.95.15.193]:63241 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312279AbSDCXfG>;
	Wed, 3 Apr 2002 18:35:06 -0500
To: Craig <penguin@wombat.ca>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] 2.4: BOOTPC /proc info.
In-Reply-To: <1017802992.2940.602.camel@phantasy.suse.lists.linux.kernel> <Pine.LNX.4.42.0204031759090.711-100000@wombat.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Apr 2002 01:35:02 +0200
Message-ID: <p73vgb8s6e1.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig <penguin@wombat.ca> writes:

> Marcelo,
>   This patch is against 2.4.19-pre5, please apply.

This is unbelievable ugly. Can't you just save the packet as a binary
buffer, output it as binary in /proc and parse and format it in user space ?

Better would be to not use bootpc at all in kernel, but run it in initrd
(that is the long term plan anyways, removing dhcp/bootp completely
and only supporting them from initrd) 


-Andi

