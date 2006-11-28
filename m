Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935934AbWK1RdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935934AbWK1RdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935939AbWK1RdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:33:05 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:41891 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S935934AbWK1RdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:33:02 -0500
Subject: Re: 2.6.19-rc6-rt5
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0611220606m31c397d1ubafae3460d36db09@mail.gmail.com>
References: <20061120220230.GA30835@elte.hu>
	 <5bdc1c8b0611220606m31c397d1ubafae3460d36db09@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 12:33:25 -0500
Message-Id: <1164735207.1701.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-22 at 06:06 -0800, Mark Knecht wrote:
> Ingo,
>    I started building the new kernels a few days ago with your
> 2.6.19-rc6-rt0 announcement. The kernels have built fine but so far I
> am unable to build the realtime-lsm package against them so no reason
> to reboot.
> 
>    I know there were some comments awhile back about being required to
> switch to PAM. Has that occurred?
> 
>    If not then there is a regression issue for realtime-lsm. 

As Realtime LSM is an out of tree module and there's no stable kernel
module API it's impossible to prevent regressions.

That being said, the realtime LSM patch is so simple that it should work
- how exactly does it fail?

Lee

