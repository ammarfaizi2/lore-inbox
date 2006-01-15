Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWAONUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWAONUF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 08:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWAONUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 08:20:04 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:17832 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751928AbWAONUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 08:20:03 -0500
Date: Sun, 15 Jan 2006 16:19:58 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, saw@saw.sw.com.sg, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20060115161958.07e3c7f1@vitb.dev.rtsoft.ru>
In-Reply-To: <20060105181826.GD12313@stusta.de>
References: <20060105181826.GD12313@stusta.de>
Organization: MontaVista software, Inc.
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006 19:18:26 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> This patch removes the obsolete drivers/net/eepro100.c driver.
> 
> Is there any known problem in e100 still preventing us from removing 
> this driver (it seems noone was able anymore to verify the ARM problem)?
> 
I think I am recalling some problems on ppc82xx, when e100 was stuck on startup,
and eepro100 worked just fine. 

Even if the patch below will be scheduled for application, we need to set up enough time 
for approval that e100 will be fine for all the up-to-date hw; or it should be fixed/updated before eepro100 removal.

> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
>


-- 
Sincerely, 
Vitaly
