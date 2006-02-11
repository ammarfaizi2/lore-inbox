Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWBKNxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWBKNxS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 08:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWBKNxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 08:53:18 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:22027 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932284AbWBKNxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 08:53:17 -0500
Date: Sat, 11 Feb 2006 14:53:22 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Arthur Othieno <apgo@patchbomb.org>
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] matroxfb: simply return what i2c_add_driver() does
Message-Id: <20060211145322.151f47d4.khali@linux-fr.org>
In-Reply-To: <11396556342192-git-send-email-apgo@patchbomb.org>
References: <11396556342192-git-send-email-apgo@patchbomb.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arthur,

> insmod will tell us when the module failed to load. We do no further
> processing on the return from i2c_add_driver(), so just return what
> i2c_add_driver() did, instead of storing it.
> 
> Add __init/__exit annotations while we're at it.
> 
> Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

Acked-by: Jean Delvare <khali@linux-fr.org>

Arthur, do you have such a device yourself? I have another cleanup
patch for this driver and am looking for testers.

Thanks,
-- 
Jean Delvare
