Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTLLMgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 07:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTLLMgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 07:36:41 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:60105 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S264542AbTLLMgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 07:36:40 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 ps2 mouse giving corrupt data?
Date: Fri, 12 Dec 2003 12:36:38 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312121236.38692.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just switched from l2.4 to 2.6 on my thinkpad, and the mouse does 
something wierd when I boot into x (kde)

startx, then wait for everything to load, then move mouse. Mouse goes crazy, 
menus pop up everywhere as though I were pressing buttons, and after about 3 
seconds, it all settles down and works perfectly.

So whats causing this? I 've read about the mouse detection stuff in recent 
2.6 giving incorrect resolutions and stuff, but thats doesn't apply here. Its 
getting a load of bad data.

A buffer_len load of crud is being provided before the real stuff arrives 
perhaps?

Andrew Walrond

PS For 'mouse' read 'Little Red Nipple' which AFAIK is just a ps2 mouse as far 
as linux is concerned. Worked for 2.4 anyway.

