Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290887AbSASAeJ>; Fri, 18 Jan 2002 19:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290888AbSASAd7>; Fri, 18 Jan 2002 19:33:59 -0500
Received: from air-1.osdl.org ([65.201.151.5]:15366 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S290887AbSASAdw>;
	Fri, 18 Jan 2002 19:33:52 -0500
Subject: Re: [PATCH] AGP update for i820 and i860 chipsets
From: Andy Pfiffer <andyp@osdl.org>
To: Daniele Venzano <venza@iol.it>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Nicolas Aspert <Nicolas.Aspert@epfl.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020118221153.GA1263@renditai.milesteg.arr>
In-Reply-To: <20020118221153.GA1263@renditai.milesteg.arr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 18 Jan 2002 16:33:41 -0800
Message-Id: <1011400424.954.0.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-18 at 14:11, Daniele Venzano wrote:
> This patch fixes the ID for i860 chipset and adds support for the UP
> version of i820 AGP bridge. I made it against kernel 2.4.17. It compiles
> and works both builin or as a module.

I was looking for this fix just yesterday.

This patch works on my system.  You might want to take the extra step
and fix the PCI device id list, too:

% lspci | grep Unknown
00:00.0 Host bridge: Intel Corporation: Unknown device 2531 (rev 04)
00:02.0 PCI bridge: Intel Corporation: Unknown device 2533 (rev 04)
% 

Andy


