Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUIAHRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUIAHRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUIAHRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:17:45 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:42936 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S266905AbUIAHRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:17:42 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Wed, 1 Sep 2004 09:10:59 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409010428.01056.adaplas@hotpop.com>
In-Reply-To: <200409010428.01056.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409010910.59827.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 22:28, Antonino A. Daplas wrote:
>
> Open drivers/video/tdfxfb.c, change the following (at line 1278):
>
> info->flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
>
> to
>
> info->flags		= FBINFO_DEFAULT;
>

The scrolling speed doesn't change.

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.8-gentoo-r3)

