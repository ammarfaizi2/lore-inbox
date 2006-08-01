Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751720AbWHARjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWHARjt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWHARjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:39:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41097 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750929AbWHARjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:39:49 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1154450847.5605.21.camel@localhost> 
References: <1154450847.5605.21.camel@localhost>  <1154354115351-git-send-email-hskinnemoen@atmel.com> <20060731174659.72da734f@cad-250-152.norway.atmel.com> <1154371259.13744.4.camel@localhost> <20060801101210.0548a382@cad-250-152.norway.atmel.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 01 Aug 2006 18:39:36 +0100
Message-ID: <6189.1154453976@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> +			/* Set the pseudoflavor */
> +			if (!(data->flags & NFS_MOUNT_SECFLAVOUR))
> +				data->pseudoflavor = RPC_AUTH_UNIX;
>  			memset(data->context, 0, sizeof(data->context));

Should the memset() conditional also?

David
