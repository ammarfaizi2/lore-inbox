Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbUCTL07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 06:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbUCTL07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 06:26:59 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:36573 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263362AbUCTL06 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 06:26:58 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: USB mouse prevents processor power state C3
Date: Sat, 20 Mar 2004 12:26:55 +0100
User-Agent: KMail/1.6.1
Cc: linux-usb-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403201227.00195.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm trying to figure out why the fact that my USB mouse is plugged in prevents 
the processor from entering C3 state, the bus-master flag is at  ffffffff.

Unplugging the mouse solves the problem. It seems rather strange to me that 
this would influence it, since It's not used at all...

I ran across this thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107633614409619&w=2

Has anyone some more info on it?

Thanks.

Please CC me on answers from linux-usb, i'm not on that mailing list.

Jan
-- 
omnibiblious, adj.:
	Indifferent to type of drink.  Ex: "Oh, you can get me anything.
	I'm omnibiblious."
