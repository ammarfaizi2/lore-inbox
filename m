Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUHUIjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUHUIjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268905AbUHUIjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:39:09 -0400
Received: from qfep04.superonline.com ([212.252.122.160]:55949 "EHLO
	qfep04.superonline.com") by vger.kernel.org with ESMTP
	id S268900AbUHUIjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:39:05 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 11:39:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200408211127.45076.vda@port.imtp.ilyichevsk.odessa.ua>
Thread-Index: AcSHWO04qYEV00kzQ4mztCn/7jXpRAACVL8w
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S268900AbUHUIjF/20040821083906Z+1959@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You are misled. There are two machines in this scenario. One is our linux
box and the other is a 6000$ access concentrator which cannot be replaced
just for this reason. Embedded code in those network devices are often
bulky, so this is another problem the huge device is causing. Only "linux"
can do some hack in this case... So only way, hack the kernel...

In reply to the following;
--------------------------
Of course you can hack the kernel to do it.

However, by replacing that box with Linux device you
get one more Linux box and you will be capable of
doing whole slew of useful things, like traffic filtering, shaping,
accounting, Ethernet bridging, etc etc etc, if/when you will need it.
You can easily debug problems with tools like tcpdump and ethereal.
I simply cannot list everything Linux can do, I don't plan to write
a novel here ;]

I bet current 'crazy box' has nothing even vaguely resembling
these capabilities. Heck, it cannot do standard TCP properly.
So there is little reason to waste your time trying to work around it.
-- 
vda



