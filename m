Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265718AbUFOPyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbUFOPyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbUFOPyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:54:14 -0400
Received: from beholder.math.fu-berlin.de ([160.45.44.200]:57475 "EHLO
	beholder.fefe.de") by vger.kernel.org with ESMTP id S265718AbUFOPyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:54:04 -0400
Date: Tue, 15 Jun 2004 17:53:54 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: ieee1394 still utterly broken in 2.6.7-rc3
Message-ID: <20040615155354.GA7988@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it too much to ask to at least revert back to the ieee1394 code from
2.6.3 before shipping the final 2.6.7?

Firewire was dysfunctional sind 2.6.3, and still has not been fixed,
despite several updates to the code.

Please, 2.6 is supposed to be a stable kernel, for people to use in
production environments.

Here's what happens with every kernel since 2.6.4:

  kernel boots
  finds firewire hard disk
  creates device
  boot sequence tries to mount disk
  computer hangs
  I pull the cable
  computer continues booting, just without firewire disk

It's an Athlon mainboard with VIA chipset.

Felix
