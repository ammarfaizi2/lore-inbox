Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268896AbUHUIS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268896AbUHUIS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268897AbUHUIS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:18:28 -0400
Received: from qfep04.superonline.com ([212.252.122.160]:24770 "EHLO
	qfep04.superonline.com") by vger.kernel.org with ESMTP
	id S268896AbUHUISZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:18:25 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 11:18:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200408211111.24019.vda@port.imtp.ilyichevsk.odessa.ua>
Thread-Index: AcSHVqR/B9O63sa5Rom/a9gMapJiCwACJkVA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S268896AbUHUISZ/20040821081825Z+1927@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That is not much of an intelligible idea. A way to hack the kernel could be
found as I still presume. "Turn off checksums" but not by re-writing the
whole tcp code in the kernel. Isn't that possible ? Linux is an operating
system of infinite possibilities, right ? But only if you know how to hack
it...

-----Original Message-----
From: Denis Vlasenko [mailto:vda@port.imtp.ilyichevsk.odessa.ua] 
Sent: Saturday, August 21, 2004 10:11 AM
To: Josan Kadett; 'Aidas Kasparas'
Cc: linux-kernel@vger.kernel.org
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level

On Saturday 21 August 2004 12:00, Josan Kadett wrote:
> The problem is that the interface 192.168.1.1 does not allow any
> tranmission to occur. An implementation error I think... We send packets
to
> 192.168.1.1, we get no reply, but when we send packets to 192.168.77.1 we
> get the replies (that is where the abnormality begins). However; the
> replies are now sourced from 192.168.1.1 instead. That is, the blasted
code
> in the device calculates the checksum using the wrong IP address which it
> thinks it is assigned to...

Maybe dust off some old Pentium 133 and replace that piece of electronic
crap with decent Linux machine?
-- 
vda




