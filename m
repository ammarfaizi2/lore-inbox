Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWHORKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWHORKS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWHORKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:10:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:24486 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030366AbWHORKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:10:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: 2.6.18-rc4-mm1
Date: Tue, 15 Aug 2006 19:14:07 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <200608141954.29656.rjw@sisk.pl> <20060815.230741.41198421.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060815.230741.41198421.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151914.07420.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 16:07, Atsushi Nemoto wrote:
> On Mon, 14 Aug 2006 19:54:29 +0200, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
> > 
> > makes my x86_64 SMP box (dual-core Athlon 64 on an ULi-based AsRock mobo) run
> > _very_ slow (it would take tens of minutes to boot the box if I were as
> > patient as to wait for that).
> > 
> > Strangely enough, on a non-SMP box I have tested it on it works just fine.
> 
> Oh, my fault.
> 
> Could you retry with this patch?

Yes, the patch helps.

Thanks,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
