Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUIAHct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUIAHct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268851AbUIAHcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:32:48 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:6061 "EHLO
	mailfe03.swip.net") by vger.kernel.org with ESMTP id S268803AbUIAHci convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:32:38 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Wed, 1 Sep 2004 09:32:06 +0200
From: Frederik Deweerdt <frederik.deweerdt@laposte.net>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/4] v4l: bttv driver update.
Message-ID: <20040901073206.GA21887@gilgamesh.home.res>
Mail-Followup-To: Kernel List <linux-kernel@vger.kernel.org>
References: <20040831152405.GA15658@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040831152405.GA15658@bytesex>
User-Agent: Mutt/1.4.2i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Aug 31, 2004 at 05:24:05PM +0200, Gerd Knorr écrivit:
>   Hi,
[...] 
> -	rc=bttv_I2CRead(btv,(PX_I2C_PIC<<1),NULL);
> +	rc=bttv_I2CRead(btv,(PX_I2C_PIC<<1),0);

Sorry if it's irrelevant here, but I though there had been a 
campaign advocating "NULL instead of 0 in the Linux Kernel"?
Ref: http://lkml.org/lkml/2004/7/8/9

Regards,
Frederik Deweerdt
frederik.deweerdt@laposte.net
