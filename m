Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWAPADy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWAPADy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 19:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWAPADy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 19:03:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751002AbWAPADx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 19:03:53 -0500
Date: Sun, 15 Jan 2006 16:03:40 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: Adrian Bunk <bunk@stusta.de>, jgarzik@pobox.com, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20060115160340.6f8cc7d6@localhost.localdomain>
In-Reply-To: <20060115161958.07e3c7f1@vitb.dev.rtsoft.ru>
References: <20060105181826.GD12313@stusta.de>
	<20060115161958.07e3c7f1@vitb.dev.rtsoft.ru>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2006 16:19:58 +0300
Vitaly Bordug <vbordug@ru.mvista.com> wrote:

> On Thu, 5 Jan 2006 19:18:26 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch removes the obsolete drivers/net/eepro100.c driver.
> > 
> > Is there any known problem in e100 still preventing us from removing 
> > this driver (it seems noone was able anymore to verify the ARM problem)?
> > 
> I think I am recalling some problems on ppc82xx, when e100 was stuck on startup,
> and eepro100 worked just fine. 
> 
> Even if the patch below will be scheduled for application, we need to set up enough time 
> for approval that e100 will be fine for all the up-to-date hw; or it should be fixed/updated before eepro100 removal.
> 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> >

How about doing what was done with devfs removal, and remove it
from the config menu system for a couple of releases.
