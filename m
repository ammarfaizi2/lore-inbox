Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVJaQkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVJaQkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVJaQkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:40:51 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10212 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932460AbVJaQku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:40:50 -0500
Subject: Re: 2.6.14-rt1 - xruns in a certain circumstance
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: "K.R. Foley" <kr@cybsft.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b0510310726t105f8f8emd1d044f760a8a1eb@mail.gmail.com>
References: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>
	 <50256.192.249.47.11.1130771450.squirrel@webmail2.pair.com>
	 <5bdc1c8b0510310726t105f8f8emd1d044f760a8a1eb@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 11:39:19 -0500
Message-Id: <1130776760.32101.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 07:26 -0800, Mark Knecht wrote:
>    I'm going to do as Lee and Ingo suggest, now that I have a test
> that seems to create xruns pretty qickly. Hopefully I'll capture
> something of interest. However I'm questioning exactly what the video
> problem would be since I don't create xruns when watching MythTV full
> screen. Only get them when watching in this preview window. That said
> it is an ATI PCI-Express card but since it's 2.6.14 there is no ATI
> driver support. My kernel is currently trying to load fglrx (the ATI
> driver) and failing since it doesn't support this kernel. I'll clean
> up the video driver setup and retest.

Please try my first suggestion, just set Option "NoAccel" to the Device
section of your xorg.conf.

Lee

