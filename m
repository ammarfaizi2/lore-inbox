Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWCXDrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWCXDrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 22:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWCXDro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 22:47:44 -0500
Received: from fmr17.intel.com ([134.134.136.16]:29645 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751537AbWCXDro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 22:47:44 -0500
Subject: Re: [2.6.16-gitX] heavy performance regression in ipw2200 wireless
	driver
From: Zhu Yi <yi.zhu@intel.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Ketrenos <jketreno@linux.intel.com>, netdev@vger.kernel.org
In-Reply-To: <5a4c581d0603230602s1a868a4apbfd79ec2bc568011@mail.gmail.com>
References: <5a4c581d0603221724m391f5466l8a2af3ae7f0aacae@mail.gmail.com>
	 <20060322191057.304962a4.akpm@osdl.org>
	 <5a4c581d0603230602s1a868a4apbfd79ec2bc568011@mail.gmail.com>
Content-Type: text/plain
Organization: Intel Corp.
Date: Fri, 24 Mar 2006 11:41:14 +0800
Message-Id: <1143171674.17270.195.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 15:02 +0100, Alessandro Suardi wrote:
> That scp test shows 50%ish - but that was a quickie. The VNC
>  client even reported a 719Kbps throughput down from the more
>  usual 11500Kbps it starts off with. The first scp I tried when the
>  sluggishness was intolerable was going at 200KB/s - which
>  shows the problem can easily get in the neighborhood of an
>  order of magnitude.

What kind of wireless encryption do you use? We turned off hardware
encryption by default recently as a workaround for a firmware restart
bug. You might want to load module with "modprobe ipw2200 hwcrypto=1"
and retest.

Thanks,
-yi

