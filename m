Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWAQW1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWAQW1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWAQW1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:27:18 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:1734 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964870AbWAQW1R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:27:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VAF1N26IjKKknZ8U0LwzbwtvM/xR2rEuEpMoU710PdzeolQvk3NfNuFc141hF5pGN31rahvWXUYZV10WXii2Y+BquEIoEsLRrrGOg8n2amIwqr8qUCNthpaDRGYLayz1BLJDme1zpkggReHVu87+3HuQxh7AKpPjsm15sZEBy3E=
Message-ID: <56a8daef0601171427s75894fid0f8c4f9e2b28e50@mail.gmail.com>
Date: Tue, 17 Jan 2006 14:27:16 -0800
From: John Ronciak <john.ronciak@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Vitaly Bordug <vbordug@ru.mvista.com>, jgarzik@pobox.com,
       saw@saw.sw.com.sg, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060117184834.GD19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105181826.GD12313@stusta.de>
	 <20060115161958.07e3c7f1@vitb.dev.rtsoft.ru>
	 <20060115160340.6f8cc7d6@localhost.localdomain>
	 <20060117184834.GD19398@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't of any problems reported against e100 that have not been
talked about in this thread (in old ARCH types).  I think the eepro100
driver should be removed from the config "just in case" but we are in
full support of the e100 driver and if somebody says that it's not
working on one of the different ARCHs we are willing to work with them
to get it fixed.  The problem is that we don't have all these
different ARCH systems around to test against.

Another thing is that removal of the driver (or disabling the config)
will hopefully force the issue in that people with these ARCHs will
use the e100 and if they have problems we can get them fixed in the
e100 driver.  At this point nobody seems to be able to define a "real"
problem other than talking about it.


--
Cheers,
John
