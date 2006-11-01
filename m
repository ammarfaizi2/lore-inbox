Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423925AbWKABUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423925AbWKABUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423924AbWKABUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:20:46 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34771 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1423923AbWKABUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:20:40 -0500
Message-ID: <4547F666.6030706@pobox.com>
Date: Tue, 31 Oct 2006 20:20:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       linux-netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Mike Phillips <mikep@linuxtr.net>
Subject: Re: [PATCH] tokenring: fix module_init error handling
References: <20061028185214.GJ9973@localhost>
In-Reply-To: <20061028185214.GJ9973@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita wrote:
> - Call platform_driver_unregister() before return when no cards found.
>   (fixes data corruption when no cards found)
> 
> - Check platform_device_register_simple() return value
> 
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Mike Phillips <mikep@linuxtr.net>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

applied


