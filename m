Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTGATJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTGATJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:09:44 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:7553 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id S263451AbTGATJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:09:38 -0400
Subject: ICH5 SATA causes high interrupt/system load?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1057087443.3373.4.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 01 Jul 2003 21:24:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After reading about problems with ICH5 SATA (Intel 875P) I've
set my BIOS back to normal mode for the SATA controller. So now the SATA
drive appears as hdc instead of hde.

The SATA drive was working in both situations (enhanced/normal) the only
difference is that with normal mode there no high system load caused by
the SATA controller (As I reported in a previous mail).

What's causing the high interrupt count in 'enhanced' mode?

Nb I have seen this on both 2.4.21 and 2.5.73.

Cheers,

Jurgen

