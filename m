Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWALLQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWALLQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWALLQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:16:14 -0500
Received: from [194.67.67.195] ([194.67.67.195]:52123 "EHLO
	trinity.dezcom.mephi.ru") by vger.kernel.org with ESMTP
	id S965033AbWALLQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:16:13 -0500
Date: Thu, 12 Jan 2006 14:13:15 +0300
From: Alexander Sbitnev <nwshuras@dezcom.mephi.ru>
X-Mailer: The Bat! (v3.0.1.33) UNREG / CD5BF9353B3B7091
X-Priority: 3 (Normal)
Message-ID: <575186548.20060112141315@dezcom.mephi.ru>
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: SX8 stability issue
In-Reply-To: <43C55CAD.90609@pobox.com>
References: <204883.20060111160652@dezcom.mephi.ru> <43C55CAD.90609@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-DEZCOM-MailScanner: Found to be clean
X-DEZCOM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.941,
	required 5, ALL_TRUSTED -3.30, AWL 0.36, BAYES_50 0.00)
X-MailScanner-From: nwshuras@dezcom.mephi.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, the in-kernel sx8 driver does not use NCQ at all, so you would
> have to have modified the driver to turn it on.  Presumably this means 
> there is a bug in your modifications?

Hmmm... Ok, driver doesn't care about NCQ at all, as i understood all NCQ work
performed by it's firmware. Then we have just a stability issue, not
directly linked to NCQ. Right?
              Shuras




