Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVCIX5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVCIX5C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVCIX4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:56:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:3495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262065AbVCIXu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:50:56 -0500
Date: Wed, 9 Mar 2005 15:50:49 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Russell King <rmk+serial@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Someting's busted with serial in 2.6.11 latest
Message-ID: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some checkin since 2.6.11 has caused the serial driver to
drop characters.  Console output is chopped and messages are garbled.
Even the shell prompt gets truncated.

