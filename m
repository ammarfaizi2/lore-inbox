Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTARBwg>; Fri, 17 Jan 2003 20:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTARBwg>; Fri, 17 Jan 2003 20:52:36 -0500
Received: from f25.sea1.hotmail.com ([207.68.163.25]:60170 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261868AbTARBwg>;
	Fri, 17 Jan 2003 20:52:36 -0500
X-Originating-IP: [24.236.178.141]
From: "T C" <blonde_les_cutie@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Sat, 18 Jan 2003 02:01:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F25CIlWrdFOSPUPeKlj0000056d@hotmail.com>
X-OriginalArrivalTime: 18 Jan 2003 02:01:30.0679 (UTC) FILETIME=[84C65470:01C2BE95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i huess this is where this is supopsed to go, myabe not, if possible reply 
to trans13nt@jyll.net. Anyhow, heres the bug I think I found



I'm running gentoo on a 2.4.20-ck kernel

I use a usb mouse which means I need the input module. Which mean in Input 
Core Support I need to make Input Core Support a module (which makes the 
input module) and mousedev (which makes the mousdev module). But unless I 
ALSO make the keybdev module, when I try to modprobe input it says it cannot 
be loaded because keybdev could not be found. Once input, mousedev, and 
keybdev have been loaded I can then unlaod keybdev,

that pretty much the extent of what I think is a bug. Again, please reply to 
trans13nt@jyll.net.

_________________________________________________________________
MSN 8: advanced junk mail protection and 2 months FREE*. 
http://join.msn.com/?page=features/junkmail

