Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUAXTCg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 14:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266996AbUAXTCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 14:02:35 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:25821 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261735AbUAXTCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 14:02:34 -0500
Message-ID: <4012C132.5090508@colorfullife.com>
Date: Sat, 24 Jan 2004 20:02:10 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] [2.4] forcedeth network driver
References: <4012A738.2060009@gmx.net> <20040124195951.A1304@electric-eye.fr.zoreil.com>
In-Reply-To: <20040124195951.A1304@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:

>-> get_npriv() can still dereference a NULL pointer.
>  
>
Ups, I think I fixed that. It seems the fix got lost. Sorry.

>+       if (!dev->base_addr)
>+               goto out_disable;
>                     ^^^^^^^^^^^
>-> shouldn't it be out_relreg ?
>  
>
Ok, thanks.

--
    Manfred

