Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTBDVDS>; Tue, 4 Feb 2003 16:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTBDVDS>; Tue, 4 Feb 2003 16:03:18 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:13069 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267346AbTBDVDS>; Tue, 4 Feb 2003 16:03:18 -0500
Date: Tue, 4 Feb 2003 16:09:51 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: b_adlakha@softhome.net
cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe from module-init*
In-Reply-To: <courier.3E3EEFDF.00004C36@softhome.net>
Message-ID: <Pine.LNX.3.96.1030204160401.1060C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003 b_adlakha@softhome.net wrote:

> why does modprobe say :
> "ignoring bad line starting with probeall" after reading modules.devfs?
> what is probeall anyway?
> what can I do to stop these irritating messages everytime I boot? 

I don't believe probeall is supported yet. As I recall it probes each
module in the list, while 'probe' stops after the first one inserts
without error.

Like:
  probe eth0 eehack e100 eepro100

If you boot a lot of kernels.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

