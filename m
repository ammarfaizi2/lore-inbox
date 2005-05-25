Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVEYIRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVEYIRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 04:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVEYIRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 04:17:40 -0400
Received: from [81.3.11.18] ([81.3.11.18]:32159 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S261267AbVEYIRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 04:17:34 -0400
Date: Wed, 25 May 2005 10:17:01 +0200
From: Konstantin Kletschke <lists@ku-gbr.de>
To: linux-kernel@vger.kernel.org
Subject: forcedeth NIC losses link... some sort of
Message-ID: <20050525081700.GA27991@synertronixx3>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people!

I am using the forcedeth with a recent nforce3 chipset.
The chipset is in a Shuttle XPC SN85G4V2 barebone with an AMD64 on it.

Every once in a while (couple of times a day, yesterday nearly unusable)
the ethernet connection does not send any packets anymore.

I have this problem with 2.6.11 or 2.6.12-rc3 or 2.6.12-rc4 and I turned
on the dprintk in drivers/net/forcedeth.c (without IRQ debugging :p).

Watching the output I have the feeling it still receives ethernet
packages when breaking (open ssh connects still get text lines) but
nothing is sendet anymore. When broken I see roughly once in a second a
phy advertise message. Sometimes replugging the cable helps, sometimes
rmmod forcedeth && modprobe forcedeth, most often I have to powercycle
the PC.

I am showing up here with this problem to get some advice on how to
start debugging this beast, may be the module author(s) are here also
and can me advice how to effective helping debugging this driver or
somebody else. I suspect here are a couple of people knowing the driver
better than me. I am willing to change that :)

Regards, Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
