Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbTDBUZc>; Wed, 2 Apr 2003 15:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTDBUZc>; Wed, 2 Apr 2003 15:25:32 -0500
Received: from havoc.daloft.com ([64.213.145.173]:4535 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261824AbTDBUZb>;
	Wed, 2 Apr 2003 15:25:31 -0500
Date: Wed, 2 Apr 2003 15:36:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Dennis Cook <cook@sandgate.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Deactivating TCP checksumming
Message-ID: <20030402203653.GA2503@gtf.org>
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com> <20030401122824.GY29167@mea-ext.zmailer.org> <b6fda2$oec$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fda2$oec$1@main.gmane.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 02:22:59PM -0500, Dennis Cook wrote:
> Using RH Linux kernel 2.4.18, setting "features" bit NETIF_F_IP_CSUM does
> not appear
> to keep a valid IP checksum from being computed in packets presented to my
> driver
> for transmission. So having HW compute outgoing checksum buys nothing.

You are not using sendfile(2), which is required to activate h/w csum.

	Jeff



