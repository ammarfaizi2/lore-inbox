Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUCQPyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 10:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbUCQPyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 10:54:11 -0500
Received: from fmr11.intel.com ([192.55.52.31]:48581 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S261668AbUCQPyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 10:54:09 -0500
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
From: Len Brown <len.brown@intel.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F571D@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F571D@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079538829.2560.56.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Mar 2004 10:53:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look in /proc/acpi/processor/CPU0/power
and see if the usage for the higher C-state numbers
is different between the two kernels.

Higher c-states save more power.

cheers,
-Len


