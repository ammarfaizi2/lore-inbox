Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317756AbSGVR6Y>; Mon, 22 Jul 2002 13:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317759AbSGVR6X>; Mon, 22 Jul 2002 13:58:23 -0400
Received: from moonshine.cih.com ([204.69.206.3]:51639 "HELO cih.com")
	by vger.kernel.org with SMTP id <S317756AbSGVR6X>;
	Mon, 22 Jul 2002 13:58:23 -0400
Date: Mon, 22 Jul 2002 11:01:30 -0700 (PDT)
From: "Craig I. Hagan" <hagan@cih.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: APIC issues with 2.4.19-rcX-acY
In-Reply-To: <1027199098.16819.37.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207221058320.20806-100000@svr.cih.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've seen the following error when booting a dell 2550 (dual p3, serverworks  
CNB20HE chipset):

APIC error on CPU0: 08(08)
(repeats until i hard reset the machine)

I've seen this for every combination of 2.4.19-rc/ac patch that i've tried,
however the 2.4.19-rc kernels work fine (my test system is currently running
2.4.19-rc3). I'd like to help resolve this issue, but I'm not quite sure as to
where to start save rolling back all of the apic deltas in the -ac patch
series.

-- craig

