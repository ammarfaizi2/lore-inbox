Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbTKZWbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTKZWbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:31:14 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:23956 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264351AbTKZWbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:31:11 -0500
Date: Wed, 26 Nov 2003 17:20:52 -0500
From: Ben Collins <bcollins@debian.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Beaver In Detox AND IEEE1394 badness message
Message-ID: <20031126222052.GA462@phunnypharm.org>
References: <20031126221933.93553.qmail@web40909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031126221933.93553.qmail@web40909.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> blk: queue dfd658cc, I/O limit 4095Mb (mask 0xffffffff)
> 
> The badness message appears AFTER this line:
> 
> ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
> Packet=[2048]
> 
> It used to appear BEFORE this line. Do the IEEE1394 fixes in the detoxed beaver
> kernel have something to do with that? Or was it a fix in an earlier kernel?

Odd, I fixed one, and another one pops up. Sucks that it doesn't show up
for me, but thanks for the traceback.

Do things operate normally for you? Disabling kernel debug will kill the
message (the symptom, not the problem). With the fixes I sent Linus, I
am mainly interested in it just working.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
