Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbWF1HOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWF1HOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbWF1HOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:14:22 -0400
Received: from www.osadl.org ([213.239.205.134]:32215 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932752AbWF1HOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:14:21 -0400
Subject: Re: [2.6 patch] drivers/mtd/devices/: remove dead _ecc code
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Adrian Bunk <bunk@stusta.de>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060627131116.GL23314@stusta.de>
References: <20060621215840.GP9111@stusta.de>
	 <1150928664.25491.34.camel@localhost.localdomain>
	 <20060627131116.GL23314@stusta.de>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 09:16:25 +0200
Message-Id: <1151478985.25491.489.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 15:11 +0200, Adrian Bunk wrote:
> nand_ecc isn't dead code.
> 
> But if I do understand correctly, you have pending patches to let the 
> code your patch made dead code and my patch would have removed be used 
> again?

Ooops, sorry for shooting too fast. You're right I rendered that stuff
dead unintentionally. But removing is not an option. I fix it proper

Thanks

	tglx



