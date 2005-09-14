Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbVINO5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVINO5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbVINO5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:57:11 -0400
Received: from xenotime.net ([66.160.160.81]:20382 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965225AbVINO5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:57:09 -0400
Date: Wed, 14 Sep 2005 07:56:59 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Cal Peake <cp@absolutedigital.net>
cc: Karel Kulhavy <clock@twibright.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: Search in make menuconfig doesn't work properly
In-Reply-To: <Pine.LNX.4.61.0509140524490.4846@lancer.cnet.absolutedigital.net>
Message-ID: <Pine.LNX.4.50.0509140754360.11686-100000@shark.he.net>
References: <20050914065010.GA8430@kestrel.twibright.com>
 <Pine.LNX.4.61.0509140524490.4846@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Cal Peake wrote:

> On Wed, 14 Sep 2005, Karel Kulhavy wrote:
>
> > I have 2.6.13 and if I press '/' in make menuconfig (Search
> > Configuration Parameter, Enter Keyword) and enther "emulation", it
> > doesn't find
> > CONFIG_BLK_DEV_IDESCSI -  SCSI emulation support.
>
> AFAIK it only matches against the CONFIG_ symbols. If you want it to do
> more cook up a patch ;)

IOW, entering:

/BLK_DEV_IDESCSI

does produce the expected (but maybe not the desired?) results.

WFM.
-- 
~Randy
