Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVIAMT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVIAMT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbVIAMT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:19:29 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:55281 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750842AbVIAMT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:19:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pt4emMjZq0f5ijq1Js+4jPjEhreoVKGO9OkNbbZM5bbx2Cr6wrpv+F/UN9VPJ0ebElnCamG8hqAmu4gsV4TmMeotWgCkeJJHB8vp1KH4XuMJO//r99KmFg9NKnGrZuGU0Mq1xwCELBDyjHPx2AiZlKmilwTrXeEDWS740qkuQkE=
Date: Thu, 1 Sep 2005 16:28:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] "space before \n" removal
Message-ID: <20050901122850.GA12870@mipter.zuzino.mipt.ru>
References: <200509011400.25793.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509011400.25793.vda@ilport.com.ua>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 02:00:25PM +0300, Denis Vlasenko wrote:
> There are 290 patches like this:
> 
> -       printk ("scsi%d : not initializing, no I/O or memory mapping known \n",
> +       printk ("scsi%d : not initializing, no I/O or memory mapping known\n",

> Feel free to download and apply to your driver.

Megapatch was added to -kj. Minor rejects fixed.

289 files changed, 998 insertions(+), 998 deletions(-)
------------------------------------------------------
[PATCH] "space before \n" removal

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>

