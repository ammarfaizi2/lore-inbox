Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbUEGETN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUEGETN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 00:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUEGETN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 00:19:13 -0400
Received: from fmr10.intel.com ([192.55.52.30]:32184 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262896AbUEGETK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 00:19:10 -0400
Subject: Re: [ACPI] [PATCH] can we compile ACPI without define CONFIG_PM ?
From: Len Brown <len.brown@intel.com>
To: sergiomb@netcabo.pt
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F9FD0@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F9FD0@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1083903538.2296.248.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 May 2004 00:18:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never occurred to me to build ACPI w/o CONFIG_PM...
There are #ifdef CONFIG_PM in the acpi code, so I guess this was on
purpose, but it makes ACPI a lot less interesting.

But I'm inclined to leave 2.4 alone except for real system failures. 
The only clean-up I'm really interested in doing in 2.4 is when it makes
maintenance via backporting from 2.6 easier.

-Len


