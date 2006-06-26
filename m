Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWFZQXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWFZQXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWFZQXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:23:50 -0400
Received: from lug.demon.co.uk ([83.104.159.110]:17814 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S1750756AbWFZQXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:23:50 -0400
From: David Johnson <dj@david-web.co.uk>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Drivers statically linked in the wrong order
Date: Mon, 26 Jun 2006 17:23:38 +0100
User-Agent: KMail/1.9.3
References: <200606261259.25959.dj@david-web.co.uk> <1151325055.3185.32.camel@laptopd505.fenrus.org>
In-Reply-To: <1151325055.3185.32.camel@laptopd505.fenrus.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606261723.39319.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 13:30, you wrote:
>
> Does this help?
>

That's great - thanks!
Replacing module_init with subsys_initcall in the I2C bus driver has solved 
the problem :-)

Regards,
David.
