Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266278AbUA2AsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 19:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266279AbUA2AsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 19:48:18 -0500
Received: from smtp09.auna.com ([62.81.186.19]:51701 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S266278AbUA2Ar7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 19:47:59 -0500
Date: Thu, 29 Jan 2004 01:47:58 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] i2c driver fixes for 2.6.2-rc2
Message-ID: <20040129004758.GA6728@werewolf.able.es>
References: <20040127233242.GA28891@kroah.com> <20040129004402.GC5830@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040129004402.GC5830@werewolf.able.es> (from jamagallon@able.es on Thu, Jan 29, 2004 at 01:44:02 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.01.29, J.A. Magallon wrote:
> 
> On 2004.01.28, Greg KH wrote:
> > Hi,
> > 
> > Here are some i2c driver fixes for 2.6.2-rc2.  It's all a bit of small
> > bugfixes and documentation updates.
> > 
> 
> After upgrading to sensors 2.8.3 (first I compiled it, then installed the
> Makdrake package when appeared), my temperatures are still mutiplied by 10.
> I use 2.6.2-rc2-mm1.
> 

Sample output:

werewolf:~# sensors
w83781d-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.98 V  (min =  +1.90 V, max =  +2.10 V)              
VCore 2:   +2.00 V  (min =  +1.90 V, max =  +2.10 V)              
+3.3V:     +3.18 V  (min =  +3.14 V, max =  +3.46 V)              
+5V:       +4.97 V  (min =  +4.73 V, max =  +5.24 V)              
+12V:     +12.04 V  (min = +11.37 V, max = +12.59 V)              
-12V:     -12.35 V  (min = -12.57 V, max = -11.35 V)       ALARM  
-5V:       -4.98 V  (min =  -5.25 V, max =  -4.74 V)       ALARM  
CPU0 Fan: 4530 RPM  (min = 84375 RPM, div = 2)              ALARM  
CPU1 Fan: 4440 RPM  (min =   -1 RPM, div = 2)              ALARM  
CPU0 Tmp:   +380°C  (high =    +0°C, hyst =  +640°C)   ALARM  
CPU1 Tmp: +405.0°C  (high =  +800°C, hyst =  +750°C)          
vid:      +2.000 V


-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc2-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
