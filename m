Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUCUCz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 21:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUCUCz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 21:55:56 -0500
Received: from fmr05.intel.com ([134.134.136.6]:4513 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S263592AbUCUCzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 21:55:55 -0500
Subject: Re: ACPI error with 2.4.26-pre5
From: Len Brown <len.brown@intel.com>
To: Andrew Clayton <andrew@digital-domain.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F5EB1@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F5EB1@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079837748.7279.784.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Mar 2004 21:55:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reporting this Andrew.

This appears to be a regression in ACPICA 20040311.

I've snagged the info you collectd and put it in this bug report:

http://bugzilla.kernel.org/show_bug.cgi?id=2339

Please add yourself to the bug's cc:, and
attach the output from acpidmp,
available in /usr/sbin/, or in pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

thanks,
-Len


