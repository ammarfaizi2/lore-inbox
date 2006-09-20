Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWITQxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWITQxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWITQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:53:13 -0400
Received: from slimak.dkm.cz ([62.24.64.34]:62421 "HELO slimak.dkm.cz")
	by vger.kernel.org with SMTP id S1751677AbWITQxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:53:12 -0400
Date: Wed, 20 Sep 2006 18:53:01 +0200
From: iSteve <isteve@rulez.cz>
To: linux-kernel@vger.kernel.org
Subject: modules.isapnpmap vs modules.alias
Message-ID: <20060920185301.21dcf9bc@silver>
X-Mailer: Sylpheed-Claws 2.4.0cvs175 (GTK+ 2.10.1; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
I'm looking at the modules.isapnpmap and I compare it with modules.alias file.
For example:

-modules.isapnpmap:
snd-mpu401           0xffff     0xffff     0x00000000  0xd041     0x06b0
-EOF

-modules.alias:
alias:          pnp:dPNPb006*
-EOF

I am trying to resolve the isapnpmap into the alias. I figured most of it, but
I'm confused by the "PNP" part. It is obvious that vendor 0xd041 conforms to
"PNP", as all devices that have vendor 0xd041 have PNP and vice versa, similarly
for eg. vendor 0xa865 and "YMH"... 

However, how can I actually translate "PNP" to "0xd041" (and/or backwards)?

Thanks in advance for any reply.
Please, CC me, as I am not subscribed to the mailing list.
-- 
 -- iSteve
