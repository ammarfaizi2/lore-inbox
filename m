Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVGUF4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVGUF4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVGUF4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:56:12 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:56680 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261646AbVGUF4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:56:11 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-pm@lists.osdl.org, ncunningham@cyclades.com
Subject: Re: [linux-pm] [PATCH] Corrected Workqueue freezer support.
Date: Thu, 21 Jul 2005 00:56:09 -0500
User-Agent: KMail/1.8.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1121923979.2939.237.camel@localhost>
In-Reply-To: <1121923979.2939.237.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507210056.09515.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 July 2005 00:32, Nigel Cunningham wrote:
> (Fixed to remove the latent mention of syncthreads).
> 
> This patch implements freezer support for workqueues. The current
> refrigerator implementation makes all workqueues NOFREEZE, regardless of
> whether they need to be or not.
>

I think kseriod and kgameportd threads can be left freezable.

-- 
Dmitry
