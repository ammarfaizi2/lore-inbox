Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVDNEBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVDNEBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 00:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVDNEBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 00:01:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:11447 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261426AbVDNEA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 00:00:57 -0400
Subject: pcmcia/cardbus issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 14:00:11 +1000
Message-Id: <1113451211.5516.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm occasionally getting "pcmcia: voltage interrogation timed out" error
when inserting a cardbus card on TI1510 based laptops here. I haven't
yet reproduced on other models. This happens with 2.6.12-rc2. The card
isn't detected right after insertion, then about 10 seconds later, it is
detected and this message appears in dmesg. It doesn't seem to be 100%
reproduceable but I'm not entirely sure at the moment.

When this happens, removing the card results in a "DANGER" message about
not beeing able to remove power from the port.

I didn't reproduce on a TI1410 based machine.

Any clue ?

Ben.


