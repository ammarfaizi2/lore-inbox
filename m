Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVCPTBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVCPTBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVCPS7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:59:47 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:61877 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262746AbVCPS5V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:57:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BW5M9Rmtihs5pLMW42jiTKq2rPIvfqQpIWEofOxeiP9C08vzhw08Xk11zFejwDUuujSjk0U4h3TgOlTJg4aD1wF3xSfqaeqov+b6C/XAH2uYZkFQdXmMNecSsCC3gwZ90XaPgW6UMPHcbowDIS7vl3cFPtKyKapFCSy1HvgRSyM=
Message-ID: <79a6fb1e050316105720a8dc85@mail.gmail.com>
Date: Wed, 16 Mar 2005 18:57:19 +0000
From: Ruben Fonseca <fonseka@gmail.com>
Reply-To: Ruben Fonseca <fonseka@gmail.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: 2.6.11-mm3 - DRM/i915 broken
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <423616CF.6060204@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20050312034222.12a264c4.akpm@osdl.org> <42360820.702@ens-lyon.org>
	 <200503142330.42556.bero@arklinux.org> <423616CF.6060204@ens-lyon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to report that I've got the same problem with 2.6.11-mm3, with
and without 4K stacks :( no DRI for now...

Rúben


On Mon, 14 Mar 2005 23:57:19 +0100, Brice Goglin
<Brice.Goglin@ens-lyon.org> wrote:
> Bernhard Rosenkraenzer a écrit :
> > On Monday 14 March 2005 22:54, Brice Goglin wrote:
> >
> >>DRM/i915 does not work on my Dell Dimension 3000 (i865 chipset).
> >>It's the first -mm kernel I try on this box. I don't whether previous -mm
> >>worked or not. Anyway, 2.6.11 works great.
> >
> >
> > You may want to try compiling without CONFIG_4KSTACKS. I've run into (not 100%
> > reproducable) problems with i855 [and i865 is using a lot of the same code]
> > and 4K stacks before...
> 
> Thanks, but I still see my problem without 4K stacks.
