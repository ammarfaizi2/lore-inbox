Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVJaGwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVJaGwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVJaGwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:52:15 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:62111 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751364AbVJaGwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:52:14 -0500
Subject: Re: 2.6.14-rt1 - xruns in a certain circumstance
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>
References: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 01:49:03 -0500
Message-Id: <1130741343.32101.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-30 at 18:28 -0800, Mark Knecht wrote:
> Hi,
>    I've been running 2.6.14-rt1 today. For the most part there seem to
> be no changes for me from 2.6.14-rc5-rt3. One place I saw xruns
> earlier is still there and I do not understand why this situation
> should be able to create xruns.
> 
>    I really think there is something to be learned from this problem.
> The way I see it What's going on with Myth is completely separate from
> what's going on with Jack, but Myth is causing xruns somehow.

Some buggy video drivers can cause this.

Are you using a DRI driver?  What video driver are you using?

Try setting:

Option "NoAccel"

in the Device section of your xorg.conf.

Lee

