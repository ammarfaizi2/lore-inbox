Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbUBXS1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUBXSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:25:53 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:6276 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S262395AbUBXSYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:24:18 -0500
Message-ID: <403B9AD0.2050006@softhome.net>
Date: Tue, 24 Feb 2004 10:41:20 -0800
From: Plaz McMan <plazmcman@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OSS API emulation in 2.6.3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OSS-API emulation does not work properly in 2.6.3 with Loki's 
UnrealTournament.

When using kernel 2.6.3 with Loki's UT, the sound is too fast. This is 
_not_ an issue with 2.6.2. Both kernels are compiled with the same 
options - ALSA with all OSS emulation options enabled. No native OSS 
support is compiled in.

OSS emulation seems to work with other programs, such as xmms, under 
both kernels.

A workaround is to compile all sound options as modules, and modprobe 
ALSA out and OSS in before starting UnrealTournament. This is quite 
clumsy, though.

-- 
x86 processor (AMD K7)
Slackware 9.1
SB Live! (emu10k1)
affected kernel: 2.6.3
-- 

