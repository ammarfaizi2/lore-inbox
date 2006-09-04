Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWIDTiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWIDTiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 15:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWIDTiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 15:38:11 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:17640 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S964970AbWIDTiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 15:38:08 -0400
Date: Mon, 4 Sep 2006 21:38:07 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide: Fix crash on repeated reset
Message-ID: <20060904193807.GA6118@rhlx01.fht-esslingen.de>
References: <1157378041.30801.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157378041.30801.78.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 04, 2006 at 02:54:01PM +0100, Alan Cox wrote:
>  	unsigned int sleeping	: 1;
>  		/* BOOL: polling active & poll_timeout field valid */
>  	unsigned int polling	: 1;
> +	 	/* BOOL: in a polling reset situation. Must not trigger another reset yet */
> +	unsigned	resetting  : 1;
> +

Inconsistent variable type declarations/formatting?

Andreas Mohr
