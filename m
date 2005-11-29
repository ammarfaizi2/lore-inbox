Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVK2Sa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVK2Sa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 13:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVK2Sa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 13:30:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932319AbVK2Sa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 13:30:58 -0500
Date: Tue, 29 Nov 2005 11:32:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
Message-Id: <20051129113210.3d95d71f.akpm@osdl.org>
In-Reply-To: <436B2819.4090909@drzeus.cx>
References: <436B2819.4090909@drzeus.cx>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
> Add support for suspending devices connected to the PNP bus. New
> callbacks are added for the drivers and the PNP hardware layer is
> told to disable the device during the suspend.

The ALSA guys have gone off and implemented their own version of this, and
it's a bit different.   I'll need to drop this patch now.

Please review http://www.zip.com.au/~akpm/linux/patches/stuff/git-alsa.patch, sort
things out?
