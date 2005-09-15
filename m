Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVIOKoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVIOKoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVIOKoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:44:16 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:25618 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932561AbVIOKoP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:44:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f8qeHYk9bGB/KodN6PeM9Ndn/T+4USLNCNqNqD1vKKe1k4MSdz99yj41NyRLXHZuEa8ec3sOdWhTCisk2Rpr0H6IyorsEIO6TvZ4/mEfMvEdTHi++psdyn2nJZiN6DQs08OKFnbEVrlx4PD/v5M/3864Gvtj7e2Pd2p3dGigtPE=
Message-ID: <6278d22205091503442c3973d4@mail.gmail.com>
Date: Thu, 15 Sep 2005 11:44:12 +0100
From: Daniel J Blueman <daniel.blueman@gmail.com>
Reply-To: daniel.blueman@gmail.com
To: Runar Ingebrigtsen <runar@mopo.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Help porting wireless InProComm IPN 2220 driver to 2.6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DI624M device is based on the Atheros 802.11g chipset, so should
work fine with the madwifi driver
[http://sourceforge.net/projects/madwifi/].

The file D-Link has made available contains either this or a
closed-source driver.

Runar Ingebrigtsen wrote:
> Hi,
> 
> D-Link made a GPL driver for the InProComm IPN 2220 wireless chipset
> found in Linksys cards.
> 
> Source: ftp://ftp.dlink.com/GPL/di624M/di624m_fw10_source.tar.gz
> 
> I really need this driver in the 2.6 kernel, as my current setup with
> ndiswrapper and the neti2220.inf is unusable due to bad throughput.
> 
> If anyone would help me I'd be willing to pay an amount for a working
> driver in the 2.6 tree. I would also need to get help using the driver
> with Ubuntu.
> 
> The hardware is a Packard Bell EasyNote A5560 laptop:
> https://wiki.ubuntu.com/HardwareSupportMachinesLaptopsPackardBell?highlight=%28packard%29%7C%28bell%29
> 
> -- 
> Runar Ingebrigtsen <runar@mopo.no>
> mopo as
___
Daniel J Blueman
