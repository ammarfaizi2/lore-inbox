Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTBFVpi>; Thu, 6 Feb 2003 16:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267649AbTBFVpi>; Thu, 6 Feb 2003 16:45:38 -0500
Received: from fmr01.intel.com ([192.55.52.18]:36810 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267481AbTBFVph>;
	Thu, 6 Feb 2003 16:45:37 -0500
Subject: Re: [PATCH][TRIVIAL] ACPI_PROCESSOR depends on CPU_FREQ
From: Rusty Lynch <rusty@linux.co.intel.com>
To: jordan.breeding@attbi.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200302062142.h16LgaF20694@caduceus.jf.intel.com>
References: <200302062142.h16LgaF20694@caduceus.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Feb 2003 13:46:38 -0800
Message-Id: <1044567999.3106.23.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 13:46, jordan.breeding@attbi.com wrote:
> I think that this: http://linus.bkbits.net:8080/linux-
> 2.5/diffs/drivers/acpi/processor.c@1.32?nav=index.html|ChangeSet@-
> 1d|cset@1.967.1.1 might be the real fix you are looking for which was commited 
> not long ago.
> 
> Jordan

yep, the next changeset fixes this.

    --rustyl

> > After pulling from Linus's tree my build broke while attempting to
> > compile drivers/acpi/processor.c because cpufreq_get_policy() and
> > cpufreq_set_policy() were not defined.
> > 
> > Here is a quick Kconfig fix.
> > 
> >     --rustyl


