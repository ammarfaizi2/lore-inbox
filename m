Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbTGPCPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 22:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270067AbTGPCPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 22:15:24 -0400
Received: from fmr01.intel.com ([192.55.52.18]:27882 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S270066AbTGPCPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 22:15:22 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A66470B981254@hdsmsx103.hd.intel.com>
From: "Brown, Len" <len.brown@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       ACPI-Devel mailing list <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: RE: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 19:35:44 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hugh Dickins [mailto:hugh@veritas.com] 

> > 		ACPI && !ACPI_HT_ONLY
> > 			Full ACPI w/o the acpi=cpu option
> 
> Shouldn't this combination also support "noht", or is that 
> too much to ask?

Can do.  It will be called CONFIG_ACPI_HT, and will be required for ACPI to
enable HT -- with or without the full CONFIG_ACPI.

Cheers,
-Len
