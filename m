Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUHTUWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUHTUWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268706AbUHTUVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:21:08 -0400
Received: from imap.gmx.net ([213.165.64.20]:1209 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268725AbUHTURm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:17:42 -0400
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Reply-To: stefandoesinger@gmx.at
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Fri, 20 Aug 2004 22:17:25 +0200
User-Agent: KMail/1.6.2
Cc: Nathan Bryant <nbryant@optonline.net>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>
References: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com> <41265443.9050800@optonline.net>
In-Reply-To: <41265443.9050800@optonline.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408202217.26399.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Maybe it's time to look at the suspend/resume callbacks on the ipw2100
> driver, anyway.
I changed LNKD to irq 7. This hit the b44 ethernet and broke S3 resume. Looks 
like it's not an ipw2100 problem.

Stefan
