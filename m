Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284820AbRLPVsa>; Sun, 16 Dec 2001 16:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbRLPVsV>; Sun, 16 Dec 2001 16:48:21 -0500
Received: from ausxc10.us.dell.com ([143.166.98.229]:27406 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S284820AbRLPVsJ>; Sun, 16 Dec 2001 16:48:09 -0500
Message-ID: <71714C04806CD5119352009027289217022C40F5@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: vherva@niksula.hut.fi, andrea@suse.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: malloc 1GB on a 2GB ia64 box fails - 17rc1 woes w/ qla1280 an
	d reiserfs
Date: Sun, 16 Dec 2001 15:47:54 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It didn't boot, though. qla1280 just hung after "verifying 
> chip" phase.
> Strangely, I don't see any changes to qla1280.c in -rc1.

That's a known heisenbug on ia64, and it's been around for a while, not new
to recent kernels.  Generally it disappears if you reboot, or try
introducing debugging to find it...

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#1 US Linux Server provider with 24% (IDC Sept 2001)
#2 Worldwide Linux Server provider with 17% (IDC Sept 2001)
#3 Unix provider with 18% in the US (Dataquest)!
