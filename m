Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUI2Oom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUI2Oom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268511AbUI2On7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:43:59 -0400
Received: from p5089E8E5.dip.t-dialin.net ([80.137.232.229]:2820 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S268535AbUI2On2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:43:28 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.9-rc2-mm4 drm and XFree oopses
Date: Wed, 29 Sep 2004 16:43:26 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040929102840.GA11325@none> <200409291517.58750.petkov@uni-muenster.de> <21d7e9970409290649520a882c@mail.gmail.com>
In-Reply-To: <21d7e9970409290649520a882c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409291643.26259.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 15:49, Dave Airlie wrote:
> > do you mean the CONFIG_AGP_INTEL option? Because my chipset is ICH4 and
> > the help text for that option doesn't mention support for ICH4 chipsets.
>
> you have an i845 GMCH, so you need intel AGP support, the ICH4 is the
> other chip if I remember my Intel chipsets correctly...
>
> Dave.
Right, my bad, my I/O controller is ICH4, sorry :) I'm going to recompile now 
with CONFIG_AGP_INTEL=y..

Thanks,
Boris.
