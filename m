Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbWFTGQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWFTGQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWFTGQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:16:09 -0400
Received: from mail.gmx.net ([213.165.64.21]:20648 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965075AbWFTGQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:16:08 -0400
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 20 Jun 2006 08:16:07 +0200
From: "Oliver Spang" <Oliver.Spang@gmx.de>
Message-ID: <20060620061607.81960@gmx.net>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-Authenticated: #480886
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following bug from the kernel (2.6.16):
BUG: Spinlock recursion on CPU#0, swapped/0 (not tained)
         lock d94566c4, .magic:dead4ead, .owner: swapper/0, .owner_cpu:0
         BUG: Spinloc lockup on CPU#0, swapper/0, d94566c4 (not tained)

Unfortunately there is no dump or call trace afterwards, and the address of the lock isn't the same on each crash.
Could you give me a hint how to get a call trace after the crash, or can I somehow resolve the address of the lock to a symbol?

Can you please CC me, because I'm not subscribed to the list.

Regards,
Oliver
-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
