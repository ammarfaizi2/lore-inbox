Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272070AbTGYNkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272072AbTGYNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:40:24 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:10063
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272070AbTGYNkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:40:22 -0400
Message-ID: <3F213961.3090501@rogers.com>
Date: Fri, 25 Jul 2003 10:06:25 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Sam Bromley <sbromley@cogeco.ca>, Torrey Hoffman <thoffman@arnor.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org>
In-Reply-To: <20030725133438.GZ1512@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Fri, 25 Jul 2003 09:55:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> On Thu, Jul 24, 2003 at 10:39:20PM -0700, Chris Ruvolo wrote:
> 
>>On Fri, Jul 25, 2003 at 12:12:34AM -0400, Ben Collins wrote:
>>
>>>Please compile with debug enabled so I can get all the output. Also,
>>>update using this patch instead of my last one.
>>
>>The list looks empty.
> 
> 
> Indeed. Please apply this patch aswell.
> 


I apologize for my ignorance. This is what I did after saving your 
patches as firewire1 and firewire2 text files:

root@localhost dave # cd /usr/src/linux
root@localhost linux # ls /home/dave/patches
firewire1  firewire2
root@localhost linux # cp /home/dave/patches/* .
root@localhost linux # cat firewire1 | patch -p1
patching file drivers/ieee1394/ieee1394_core.c
Hunk #1 succeeded at 608 (offset -1 lines).
root@localhost linux # cat firewire2 | patch -p1
missing header for unified diff at line 5 of patch
can't find file to patch at input line 5
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|Index: ieee1394_core.c
|===================================================================
|--- ieee1394_core.c    (revision 1013)
|+++ ieee1394_core.c    (working copy)
--------------------------
File to patch:
root@localhost linux #

Also, how do I compiled the modules with debug enabled? Thanks.

