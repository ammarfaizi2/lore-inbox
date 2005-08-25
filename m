Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVHYPtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVHYPtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVHYPtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:49:05 -0400
Received: from ns1.heckrath.net ([213.239.205.18]:9166 "EHLO mail.heckrath.net")
	by vger.kernel.org with ESMTP id S932190AbVHYPtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:49:04 -0400
Date: Thu, 25 Aug 2005 19:49:54 +0200
From: Sebastian Kaergel <mailing@wodkahexe.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-Id: <20050825194954.6db42e90.mailing@wodkahexe.de>
In-Reply-To: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2005 22:08:13 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Antonino A. Daplas:
>   intelfb/fbdev: Save info->flags in a local variable
> Sylvain Meyer:
>   intelfb: Do not ioremap entire graphics aperture

One of these changes broke intelfb. The same .config from 2.6.13-rc6
does no longer work for -rc7. After booting the screen stays black, but
i can type blindly. I can also start X. dmesg does not show anything
unusual. any ideas?
