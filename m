Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWERTcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWERTcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 15:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWERTcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 15:32:16 -0400
Received: from main.gmane.org ([80.91.229.2]:61582 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932136AbWERTcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 15:32:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@gmail.com>
Subject: Re: [PATCH 2/4] KBUILD: export-type enhancement to modpost.c
Date: Thu, 18 May 2006 21:31:49 +0200
Message-ID: <20060518213149.43e63165@holly.localdomain>
References: <20060510235546.510C347002F@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chaos.mk.cvut.cz
In-Reply-To: <20060510235546.510C347002F@localhost>
X-Newsreader: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006 16:55:46 -0700 (PDT)
linuxram@us.ibm.com (Ram Pai) wrote:

> +		if ((strcmp(export, "EXPORT_SYMBOL_GPL")))

I suppose there should be also == 0 like below, otherwise it fails on
any EXPORT_SYMBOL_GPL.

> +			export_type = 1;
> +		else if(strcmp(export, "EXPORT_SYMBOL") == 0)
> +			export_type = 0;
> +		else
>  			goto fail;

Regards,
-- 
Jindrich Makovicka

