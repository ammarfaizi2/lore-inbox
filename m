Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263458AbVCMFrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbVCMFrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 00:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbVCMFrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 00:47:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:13276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263458AbVCMFrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:47:07 -0500
Date: Sat, 12 Mar 2005 21:46:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml@lievin.net, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] Fix warning in gkc (make gconfig) {Scanned}
Message-Id: <20050312214645.43e57763.akpm@osdl.org>
In-Reply-To: <20050312211558.GA18623@mars.ravnborg.org>
References: <20050309083612.GA15812@lievin.net>
	<20050312211558.GA18623@mars.ravnborg.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Wed, Mar 09, 2005 at 09:36:12AM +0100, Romain Lievin wrote:
> > Hi,
> > 
> > this patch against 2.6.11-rc3 fixes some warnings about GtkToolButton in gkc
> > (the GTK Kernel Configurator).
> 
> Applied, 2 warnings fixed - 10 more to go.
> Care to take a look at them?
> Also gconfig does not support setting localversion - is this something you
> can fix too?
> 

fyi, gconfig doesn't display those cute little pixmap buttons any more. 
That bug was introduced by the patch "make gconfig work with gtk-2.4".

I'm planning on simply reverting that patch.  Which should motivate someone
to have another go at fixing it for gtk2.4.

