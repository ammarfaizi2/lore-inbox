Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264829AbUDWOoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbUDWOoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbUDWOoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:44:23 -0400
Received: from port-195-158-170-17.dynamic.qsc.de ([195.158.170.17]:56193 "EHLO
	gw.localnet") by vger.kernel.org with ESMTP id S264829AbUDWOoV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:44:21 -0400
Message-ID: <40892984.3010207@trash.net>
Date: Fri, 23 Apr 2004 16:34:44 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Hague <jim.hague@acm.org>
CC: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: Re: [PATCH]: Fix NULL-ptr dereference in pm2fb_probe
References: <XFMail.20040423091422.jim.hague@acm.org>
In-Reply-To: <XFMail.20040423091422.jim.hague@acm.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Hague wrote:

>Out of interest, can I ask if you're running pm2fb and if so on what hardware?
>  
>
I'm running pm2fb on a TVP4020, lspci -vvv looks like this:

0000:01:00.0 Display controller: Texas Instruments TVP4020 [Permedia 2] 
(rev 11)
        Subsystem: Elsa AG GLoria Synergy
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz+ UDF- 
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (48000ns min, 48000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dfde0000 (32-bit, non-prefetchable) 
[size=dfdd0000]
        Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
        Region 2: Memory at de800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [4c] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [40] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

Regards,
Patrick
