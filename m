Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbUKQSFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbUKQSFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbUKQQkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:40:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22179 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262409AbUKQQkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:40:06 -0500
Date: Wed, 17 Nov 2004 17:39:59 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Steffen A. Mork" <linux-dev@morknet.de>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: dss1_divert ISDN module compile fix for kernel 2.6.8.1
In-Reply-To: <419B662D.5020904@morknet.de>
Message-ID: <Pine.LNX.4.53.0411171725120.25776@yvahk01.tjqt.qr>
References: <419B662D.5020904@morknet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>when I switched my installation from kernel 2.4 to 2.6 I
>recognized that the ISDN module dss1_divert was marked
>incompilable (config option CONFIG_CLEAN_COMPILE must
>be turned off). The compile problem was the obsolete using
>of kernel 2.4 critical sections. I replaced the cli() stuff
>with spinlocks as explained in the Documentation/spinlocks.txt
>file. After that the module compiles and runs as expected.

I had a similar issue, but for me, it only returned a warning rather than a
compile error.


I posted something similar earlier:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109937866706186&w=2 and
http://marc.theaimsgroup.com/?l=linux-kernel&m=109943458323994&w=2 plus
the latest message I wrote a few secs ago to this list.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
