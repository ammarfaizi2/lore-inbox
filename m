Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268985AbUIXR5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268985AbUIXR5b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268991AbUIXR5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:57:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9641 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268985AbUIXR5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:57:10 -0400
Subject: Re: ArcNet and 2.6.8.1
From: Lee Revell <rlrevell@joe-job.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: "David S. Miller" <davem@davemloft.net>, yoshfuji@linux-ipv6.org,
       linux-net@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.OSF.4.05.10409240033480.21511-100000@da410.ifa.au.dk>
References: <Pine.OSF.4.05.10409240033480.21511-100000@da410.ifa.au.dk>
Content-Type: text/plain
Message-Id: <1096048629.10831.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 13:57:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 18:52, Esben Nielsen wrote:
> Oh well, I'll try to see if I can get time to make it stable with
> preemption on. Is preemption safe enough to ensure SMP safe or would I
> have to test on at least a hyperthreading machine as well?
> 

In theory preempt safe should be SMP safe, but in practice it doesn't
always work this way.  You need to test on an actual SMP system.

I am not sure that HT == SMP for your purposes either.  ISTR some cases
with the VP patches where it broke on HT but not "real" SMP.

Lee

