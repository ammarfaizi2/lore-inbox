Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbTLLJIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 04:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTLLJIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 04:08:41 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:15119 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264513AbTLLJIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 04:08:40 -0500
Message-ID: <3FD98A1F.901@nishanet.com>
Date: Fri, 12 Dec 2003 04:27:59 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
References: <200312072312.01013.ross@datscreative.com.au> <200312111655.25456.ross@datscreative.com.au> <1071143274.2272.4.camel@big.pomac.com> <200312111912.27811.ross@datscreative.com.au> <1071165161.2271.22.camel@big.pomac.com> <20031211182108.GA353@tesore.local>
In-Reply-To: <20031211182108.GA353@tesore.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Allen wrote:

>On Thu, Dec 11, 2003 at 06:52:41PM +0100, Ian Kumlien wrote:
>  
>
>>Heh, yeah, the need for disconnect is somewhat dodgy, i haven't read up
>>on th rest.
>>
>Hmm, weird.  I went to go look at the Shuttle motherboard maker's site - maybe so that I can bug them for a bios disconnect option - but I checked for a bios update first.  And sure enough like they read my mind, just posted online today, an update.  Here are the details of fixes:
>
>" Checksum:   8B00H                         Date Code: 12/05/03
>1.Support 0.18 micron AMD Duron (Palomino) CPU.
>2.Add C1 disconnect item."
>
>It's almost as they're reading this list.  This disconnect problem was discovered on the 5th (well the 5th in my timezone).  Perhaps they're aware of this issue...  I'm gonna talk to them.
>
>Jesse
>
A bios update for MSI K7N2 MCP2-T nforce2 board
fixed the crashing BEFORE these patches were developed,
but there was no documentation that would relate or explain.

http://www.msi.com.tw/program/support/bios/bos/spt_bos_detail.php?UID=436&kind=1
http://download.msi.com.tw/support/bos_exe/6570v76.exe

Award 7.6 at the top of the list. Maybe somebody can figure
out what they're doing.

Nvidia X driver for ti4200 agp8 still locks up linux though,
but X nv works fine. agp8 3d may expose the timer issue.

-Bob
