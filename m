Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271340AbUJVO45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271340AbUJVO45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271339AbUJVO44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:56:56 -0400
Received: from promon2.netbox.cz ([83.240.31.171]:61703 "EHLO brno.promon.cz")
	by vger.kernel.org with ESMTP id S271331AbUJVOyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:54:20 -0400
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at smp.c:402
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.0.3 September 26, 2003
Message-ID: <OF655F179F.433E12D6-ONC1256F35.003AE7E7-C1256F35.0051DFF0@promon.cz>
From: a.ledvinka@promon.cz
Date: Fri, 22 Oct 2004 16:54:17 +0200
X-MIMETrack: Serialize by Router on Brno/Micronic(Release 6.5.2|June 01, 2004) at
 22.10.2004 16:54:20,
	Serialize complete at 22.10.2004 16:54:20
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I was unlucky enough to run on 2.4.27 (pub/linux/kernel/v2.4/)
without custom patches
just some more modules:
        2_ft-par v1.00.0.15.tgz (promise ft3xx sata raid driver)
        i2c-2.8.8
        lm_sensors-2.8.8
with hyperthreading enabled and smp support on cpu
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz

at Oct 22 12:10:30 into
kernel BUG at smp.c:402!
invalid operand: 0000
+ some more lines which i runned through ksymoops (sorry after reboot)

I hope it will be usefull and that i have done it the correct usable way
http://portal.promon.cz/ledvinka/i/smperr/ksymoops
http://portal.promon.cz/ledvinka/i/smperr/config
Compiled on debian woody's current gcc-3.0 + binutils. Could this be the 
reason? I remember i have seen some sort of warning with kernel named in 
it and link failure...


need more info?
please CC.
