Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTI2Mec (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 08:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTI2Mec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 08:34:32 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:53484 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263301AbTI2MeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 08:34:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16248.9932.145681.897552@gargle.gargle.HOWL>
Date: Mon, 29 Sep 2003 14:34:20 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 APM/IDE double-suspend weirdness
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In test6 (and test5 and possibly earlier), when suspending
my aging Latitude with APM, the machine turns off, only to
turn itself on again one second later with the disk spinning
up. Then it turns itself off again a second later.

The kernel log contains:
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend

Apart from this, both APM suspend and resume work fine.

(ACPI is not an option on this machine, even if I wanted to
use it (I don't). APM has worked near-perfectly for years.)

/Mikael
