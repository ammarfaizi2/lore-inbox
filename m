Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWBCGVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWBCGVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 01:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWBCGVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 01:21:11 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:4753 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751197AbWBCGVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 01:21:10 -0500
Subject: Re: usb bandwidth allocation issue using 2 pvr devices (em28xx
	driver) v4l2
From: Lee Revell <rlrevell@joe-job.com>
To: Markus Rechberger <mrechberger@gmail.com>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <d9def9db0602022149o1561e1b7v9c191c873d5add46@mail.gmail.com>
References: <c967fb330602022139o77fe09d1k7149648b1afdc695@mail.gmail.com>
	 <d9def9db0602022149o1561e1b7v9c191c873d5add46@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 01:21:01 -0500
Message-Id: <1138947662.15691.241.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 06:49 +0100, Markus Rechberger wrote:
> Hi!
> 
> this should be addressed to USB subsystem developers, I also
> reproduced this issue.
> The problem is the isochronous transfer in em28xx-core.c I'm quite
> sure it's correct and the bug is somewhere deeper in the USB
> subsystem.

Is USB bandwidth checking enabled?  It's known to be broken, and should
be disabled by default...

Lee

