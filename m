Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVCCCPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVCCCPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVCCCLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:11:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:3992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261367AbVCCCBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:01:49 -0500
Date: Wed, 2 Mar 2005 18:01:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, linuxram@us.ibm.com, slpratt@austin.ibm.com
Subject: Re: [PATCH 2/2] readahead: improve sequential read detection
Message-Id: <20050302180121.61823a24.akpm@osdl.org>
In-Reply-To: <42260F30.BE15B4DA@tv-sign.ru>
References: <42260F30.BE15B4DA@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> ~$ time dd conv=notrunc if=/tmp/GIG of=/tmp/dummy bs=$((4096+512))
> 
>  2.6.11-clean:	real=370.35 user=0.16 sys=14.66
>  2.6.11-patched:	real=234.49 user=0.19 sys=12.41

whoa, nice.  Ram, can you put this through the torture-test sometime?

Thanks.
