Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSCMSr0>; Wed, 13 Mar 2002 13:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310981AbSCMSrS>; Wed, 13 Mar 2002 13:47:18 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:12473 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S310979AbSCMSrF>;
	Wed, 13 Mar 2002 13:47:05 -0500
Date: Wed, 13 Mar 2002 18:50:49 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Gerd Knorr <kraxel@bytesex.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] vmalloc_to_page() backport for 2.4
In-Reply-To: <20020313175122.C7949@bytesex.org>
Message-ID: <Pine.LNX.4.33.0203131848460.1251-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Gerd Knorr wrote:
> +EXPORT_SYMBOL_GPL(vmalloc_to_page);

Can you (or whoever made it EXPORT_SYMBOL_GPL in 2.5) please explain what
is so "GPL" about exporting this symbol, please? I can understand when
symbols related to the internals of some subsystem are GPL-only-exported
but this does not appear to be such a case.

Regards
Tigran


