Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTGIGou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 02:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbTGIGou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 02:44:50 -0400
Received: from [66.212.224.118] ([66.212.224.118]:3844 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265337AbTGIGot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 02:44:49 -0400
Date: Wed, 9 Jul 2003 02:48:11 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: printk in atomic context
In-Reply-To: <E19a8Hi-0004GN-00.arvidjaar-mail-ru@f22.mail.ru>
Message-ID: <Pine.LNX.4.53.0307090247470.5414@montezuma.mastecende.com>
References: <E19a8Hi-0004GN-00.arvidjaar-mail-ru@f22.mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003, [koi8-r] "Andrey Borzenkov[koi8-r] "  wrote:

> 
> Is it possible (safe) to use printk in atomic context, i.e. under
> spinlock or inside of preemption-disabled region?
> 
> The same question about 2.4 (here I guess only spinlock?)

Yes you can, it's rather robust.

-- 
function.linuxpower.ca
