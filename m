Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269117AbUJERp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269117AbUJERp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269120AbUJERp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:45:57 -0400
Received: from kwisatz.net1.nerim.net ([80.65.225.31]:18186 "EHLO
	www.rubis.org") by vger.kernel.org with ESMTP id S269117AbUJERpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:45:53 -0400
Date: Tue, 5 Oct 2004 19:45:49 +0200
From: Stephane Jourdois <stephane@rubis.org>
To: linux-kernel@vger.kernel.org
Message-ID: <20041005174548.GA4672@diamant.rubis.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041004020207.4f168876.akpm@osdl.org> <20041004121528.GA4635@diamant.rubis.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20041004121528.GA4635@diamant.rubis.org>
X-Operating-System: Linux 2.6.9-rc2-mm1
X-Send-From: diamant.rubis.org
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: kwisatz@rubis.org
Subject: Re: 2.6.9-rc3-mm2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on www.rubis.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 02:15:32PM +0200, Stephane Jourdois wrote:
> This kernel does not boot on my i386 laptop. I have nothing after
> "Uncompressing kernel... Ok, booting linux". The fans are increasingly
> running, so I suspect cpu is heavily used at this time. I tried to
> wait several minutes, just to see.
> 
> I have the same problem since 2.6.9-rc2-mm2. Last booting kernel is
> 2.6.9-rc2-mm1. I tried every -mm kernel between -rc2-mm1 and -rc3-mm2.
> 
> #
> # Performance-monitoring counters support
> #
> # CONFIG_PERFCTR is not set
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y
> CONFIG_BACKUP_BASE=16
> CONFIG_BACKUP_SIZE=32

Answering to myself :

disable kexec.

Sorry for the noise.

-- 
 ///  Stephane Jourdois         /"\  ASCII RIBBON CAMPAIGN \\\
(((    Ingénieur développement  \ /    AGAINST HTML MAIL    )))
 \\\   24 rue Cauchy             X                         ///
  \\\  75015  Paris             / \    +33 6 8643 3085    ///
