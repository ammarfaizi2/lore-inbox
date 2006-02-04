Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946162AbWBDLNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946162AbWBDLNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946163AbWBDLNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:13:24 -0500
Received: from mail.charite.de ([160.45.207.131]:44714 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1946162AbWBDLNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:13:24 -0500
Date: Sat, 4 Feb 2006 12:13:21 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1-mm5: APIC error on CPU0, was: 2.6.16-rc1-mm4: APIC error on CPU0: 40(40)
Message-ID: <20060204111321.GZ8140@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060202092358.GF821@charite.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060202092358.GF821@charite.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> I'm using 2.6.16-rc1-mm4 on a Medion Laptop. lame me for crap hardware.
> 
> Recent vanilla kernels were only usable when I gave them the boot options
> "irqpoll noapic lapic", and even then I had problems with messages like:
> 
> Jan 25 20:04:37 knarzkiste kernel: irq 11: nobody cared (try booting with the "irqpoll" option)
> 
> With 2.6.16-rc1-mm3 and 2.6.16-rc1-mm4 I was able to boot the box with
> no additional boot options and things seem to be working smoothly for
> the first time ever.
> 
> Now on the other hand, I'm getting these:
> 
> Feb  3 06:54:15 knarzkiste kernel: APIC error on CPU0: 40(40)

With mm5 I'm getting these:
Feb  7 22:15:03 knarzkiste kernel: APIC error on CPU0: 00(40)

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
