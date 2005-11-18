Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVKRWe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVKRWe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVKRWe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:34:26 -0500
Received: from rtr.ca ([64.26.128.89]:35023 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750933AbVKRWe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:34:26 -0500
Message-ID: <437E56EA.8070103@rtr.ca>
Date: Fri, 18 Nov 2005 17:34:18 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, tulip-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/tulip/xircom_tulip_cb.c
References: <20051118033306.GP11494@stusta.de>
In-Reply-To: <20051118033306.GP11494@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch removes the obsolete drivers/net/tulip/xircom_tulip_cb.c 
> driver.
> 
> Is there any reason why it should be kept?

Yes.  It is the only driver that works
without lockups on Xircom Cardbus cards.
Or so has been the case any time I've tried
the alternatives.

Is there any good reason to nuke it?
