Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWCGWKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWCGWKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCGWKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:10:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:12782 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750759AbWCGWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:10:30 -0500
Subject: Re: [opensuse-factory] Re[2]: 2.6.16 serious consequences /
	GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
From: Lee Revell <rlrevell@joe-job.com>
To: Silviu Marin-Caea <silviu_marin-caea@fieldinsights.ro>
Cc: opensuse-factory@opensuse.org, linux-kernel@vger.kernel.org
In-Reply-To: <200603070942.31774.silviu_marin-caea@fieldinsights.ro>
References: <OF2725219B.50D2AC48-ONC1257129.00416F63-C1257129.00464A42@avm.de>
	 <200603070942.31774.silviu_marin-caea@fieldinsights.ro>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 17:10:21 -0500
Message-Id: <1141769422.767.99.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 09:42 +0200, Silviu Marin-Caea wrote:
> On Monday 06 March 2006 14:47, s.schmidt@avm.de wrote:
> 
> > Even though people might do realtime DSP things in user space with Linux
> > and soft modems might work pretty well in userspace, in the case of Fax G3
> > an extremely short latency is required.
> 
> So basically we have to choose between:
> 
> 1. keeping a stable open source kernel and sticking to the principles that got 
> Linux where it is now
> 
> and
> 
> 2. Fax G3
> 
> Umm...

Extremely short, consistent latency is also required to use a Linux box
as a live audio effects processor and thousands of people do that.  It
works extremely well, is used by numerous professionals, and no one has
ever seriously proposed moving it to the kernel.  The POSIX realtime
APIs were designed for exactly this kind of application.

If they are doing serious realtime DSP then they should get better
results in userspace anyway, because they get to use the floating point
unit which isn't allowed in the kernel.

I suspect you last tried it in the 2.4 or early 2.6 era when patching
the kernel was required to get decent latency.

Lee

