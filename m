Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVAYBFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVAYBFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVAYBEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:04:21 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:15166 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261719AbVAYBBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:01:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=j4xaoXPa6lWr1Yzi4xgQIUO85VZkBEXuyzJMWsuw7Y0cAvF+dawjV8haT+pa21YCKex0ZFcUwSdXgrZaAimI7yiceYy5RPeagZEf7PTOGUxE/7R9+f9HJaq0Qbx/tlx0klb+/WT4CfMTRAuZSRCKwc1lNjQrT8tnUWoo6Mi6r4Q=
Message-ID: <9e47339105012417013d94f871@mail.gmail.com>
Date: Mon, 24 Jan 2005 20:01:02 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: inter_module_get and __symbol_get
Cc: davidm@hpl.hp.com, bgerst@didntduck.org,
       Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <31612.1106607781@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16885.32149.788747.550216@napali.hpl.hp.com>
	 <31612.1106607781@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 10:03:01 +1100, Keith Owens <kaos@ocs.com.au> wrote:
> On Mon, 24 Jan 2005 14:58:29 -0800,
> David Mosberger <davidm@napali.hpl.hp.com> wrote:
> >>>>>> On Tue, 25 Jan 2005 09:54:36 +1100, Keith Owens <kaos@ocs.com.au> said:
> >
> >  Keith> Does DRM support this model?

DRM will compile two different modules depending of the state of
CONFIG_AGP. A module compiled for a system with AGP will not load into
one without it.

-- 
Jon Smirl
jonsmirl@gmail.com
