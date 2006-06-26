Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWFZLuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWFZLuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWFZLug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:50:36 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:35451 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750989AbWFZLug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:50:36 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/input/misc/wistron_btns.c: section fixes
Date: Mon, 26 Jun 2006 07:50:31 -0400
User-Agent: KMail/1.9.3
Cc: mitr@volny.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
References: <20060626103509.GQ23314@stusta.de>
In-Reply-To: <20060626103509.GQ23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606260750.32863.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 06:35, Adrian Bunk wrote:
> This patch contains the following fixes:
> - it doesn't make sense to mark a variable on the stack as __initdata
> - struct dmi_ids is using the __init dmi_matched()

Since when did static variables become allocated on stack?

-- 
Dmitry
