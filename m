Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWCLHV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWCLHV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 02:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCLHV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 02:21:29 -0500
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:7577 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751481AbWCLHV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 02:21:28 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "YOSHIFUJI Hideaki / =?utf-8?q?=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?=" 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH] IPv6: Cleanup of net/ipv6/reassambly.c
Date: Sun, 12 Mar 2006 08:17:07 +0100
User-Agent: KMail/1.9.1
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200603120049.49294.ioe-lkml@rameria.de>
In-Reply-To: <200603120049.49294.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603120817.08528.ioe-lkml@rameria.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 12. March 2006 00:49, Ingo Oeser wrote:
> From: Ingo Oeser <ioe-lkml@rameria.de>
> 
> Two minor cleanups:
> 
> 1. Using kzalloc() in fraq_alloc_queue() 
>    saves the memset() in ipv6_frag_create().
> 
> 2. Invert sense of if-statements to streamline code.
>    Inverts the comment, too.
> 

These are against net-2.6.17 of course.

I also compile tested this and my other kzalloc() changes.

Forgot to mention this yesterday...


Regards

Ingo Oeser
