Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVGMK6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVGMK6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVGMK6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:58:02 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:12748 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262615AbVGMK4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:56:20 -0400
Date: Wed, 13 Jul 2005 12:56:16 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Runtime fix for intermodule.c
In-Reply-To: <20050712220705.GA12906@infradead.org>
Message-ID: <Pine.LNX.4.61.0507131255130.14635@yvahk01.tjqt.qr>
References: <20050712213920.GA9714@physik.fu-berlin.de> <20050712220705.GA12906@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> since the symbol inter_module_get cannot be resolved,
>> applying this patch will make those modules work again.
>
>There's a reason you shouldn't use it, and because of that it's
>not exported.

Oh BTW, while we're at it: With what should I replace inter_module_get? I'm 
maintaining an "ancient-sufficient" nvidia driver for myself that uses it in 
one or two places.


Jan Engelhardt
-- 
