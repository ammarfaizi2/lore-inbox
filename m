Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTKOFTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 00:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTKOFTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 00:19:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:18914 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261539AbTKOFTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 00:19:04 -0500
Message-ID: <3FB5B74E.5080707@marcush.de>
Date: Sat, 15 Nov 2003 06:19:10 +0100
From: Marcus Hartig <marcus@marcush.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031021
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 /-mm3 SATA siimage - bad disk performance
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

with the Fedora 1 kernel 2.4.22-1.2115.nptl I get with hdparm -t
(Timing buffered disk reads) 34 MB/sec. Its very slow for this drive.

With 2.6.0-test9 and -mm3 I get around "62 MB in 3.05 = 20,31". Wow"
Back to ~1998?

UDMA6 is always on. The Abit NF7-S V2 nForce2 board with an siimage 
3112a (rev2) raid controller, new BIOS.

Also with the Seagate SATA V ST380023AS I get heavy crashes with 
max_kb_per_request when I set it to 128 (all kernel). With 15kb its fine 
and stable, but so slow.

The Seagate technical support means in an email to me, that there are no 
problems with the SATA seagate drives, its only the driver ... Nice. Is 
that really so? And why get other users with new Maxtor or Western 
Digital SATA drives (in the same class) much better performance?

Thanks for all the good work,

Marcus

-- 
from the "Old Europe"

