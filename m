Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTBAPZM>; Sat, 1 Feb 2003 10:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbTBAPZM>; Sat, 1 Feb 2003 10:25:12 -0500
Received: from boden.synopsys.com ([204.176.20.19]:4823 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S264875AbTBAPZL>; Sat, 1 Feb 2003 10:25:11 -0500
Date: Sat, 1 Feb 2003 16:34:28 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre4+bk: undefined references for smp + apm
Message-ID: <20030201153428.GJ5239@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


arch/i386/kernel/kernel.o(.text+0xcd12): In function `apm_save_cpus':
: undefined reference to `set_cpus_allowed'
arch/i386/kernel/kernel.o(.text+0xcdbf): In function `apm_bios_call':
: undefined reference to `set_cpus_allowed'
arch/i386/kernel/kernel.o(.text+0xce56): In function `apm_bios_call_simple':
: undefined reference to `set_cpus_allowed'


-alex


