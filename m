Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUEXVbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUEXVbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbUEXVbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:31:42 -0400
Received: from linda.dol.sk ([217.118.103.3]:35297 "EHLO linda.dol.sk")
	by vger.kernel.org with ESMTP id S264501AbUEXVbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:31:40 -0400
From: Peter Kundrat <kundrat@kundrat.sk>
Date: Mon, 24 May 2004 23:31:30 +0200
To: linux-kernel@vger.kernel.org
Subject: controlling the watchdog for embedded board Commell LE-564
Message-ID: <20040524213130.GA4013@kundrat.sk>
Mail-Followup-To: kundrat@linda.dol.sk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Does anyone here happen to succeed in using watchdog for the 
embedded 5.25" Commell LE-564 board (other commell boards might use
similar watchdog setup).

Their support is quite incompetent and could only say that 
start address is 0x443 and stop 0x43 and that the logic is implemented
in custom ASIC.

The weirdness is that i found no way to "ping" or refresh the
timer .. if i activate it .. it fires in specified interval (set by
jumper) .. BUT even if i stop and start the timer before firing 
it doesnt defer the activation!

I tried experimenting with different possible ways to control
it (trying writing different values to the port, tried also other
addresses), but to no avail.

I believe they would not build unusable watchdog so i am hoping
there is a way .. does anyone have an idea what other ways could
i try?

Thanks and regards,

Peter
-- 
Peter Kundrat
peter@kundrat.sk
