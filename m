Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTE0IuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTE0IuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:50:18 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:50066 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S262824AbTE0IuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:50:16 -0400
Message-ID: <3ED32C0A.9030405@free.fr>
Date: Tue, 27 May 2003 11:12:42 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, "Gibbs, Justin" <Justin_Gibbs@adaptec.com>
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Justin used to say "use my latest driver" when people reported 
 >problems. Read lkml.

Probably he said that but he also answer its mail and offer support when 
someone spend time and tries to accurately report problem. I have been a 
long time aic7xxx users (both on professionnal multiprocessor servers 
and on my home machine) and Justin provided helps. And now, I have no 
more problem altthough I sometime puts GB on a streamer.

 >Its great if Justins new driver fixes the problems, but as I told him I
 >thought it was too late for it to be included. Thats my bad, too,
 > because if I had included it early in 2.4.21pre it could be in now.

Well, I reported the bug as soon as alan included them in 21-pre7-acxx 
and mentionned that the bug was fixed for me in newer justin release.

 >Justin could well have fixed the problems in the current driver instead
 >answering "use my latest driver", couldnt he?

No!. Why should he do that? Either you trust the maintainer and give him 
a chance to have its driver more widely tested by including it in stable 
kernel upon request. Here you just have applied alan patch without even 
searching (I mean asking justin) if this was the right version to 
include, thinking that it had already received some testing via alan...

What worries me the most with the current 2.4 status is that if you want 
to sell linux to manager, sys admin or anyone who can pay the bills you 
face immediately the following problems :
	- For server, you need to start applying patches for aic7xx or risk 
deadlock or even fail to boot, and probably other SMP race things due to 
the 2.4 evolution slowness. As far as I know dell use aic7XXX adapter in 
its server line (no word about SCSI RAID drivers...). Of course IDE 
cleaning is important for desktop and laptop users but not so much for 
servers,
	- For laptop, even if IDE seems to be OK, 2.4 is almost unusable 
without ACPI patches as you risk to damage your laptop with overheat 
5ACPI controlled fan) or not manage IRQ routing correctly or have dead 
keys. Then you also need some FB driver update, ... I do not even 
mention PPC laptops...

So, besides your availability, which I would regard as something that 
may be behond your real control, I would rather suggest to clearly 
define priorities for *next* 2.4 kernel so that you can use your spare 
time to make 2.4 unpatched usefull again.



-- eric running on 2.4.21-rc2-ac3 + NTFS patches + ACPI update + ...

