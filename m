Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVIAKLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVIAKLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 06:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVIAKLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 06:11:31 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:21938 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932309AbVIAKLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 06:11:31 -0400
X-Mailer: Openwave WebEngine, version 2.8.12 (webedge20-101-197-20030912)
X-Originating-IP: [62.236.163.2]
From: <mika.penttila@kolumbus.fi>
To: Andi Kleen <ak@suse.de>, <Natalie.Protasevich@unisys.com>
CC: <shaohua.li@intel.com>, <zwane@arm.linux.org.uk>, <ashok.raj@intel.com>,
       <akpm@osdl.org>, <lhcs-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <hotplug_sig@lists.osdl.org>
Subject: Re: Re: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Date: Thu, 1 Sep 2005 12:35:05 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20050901093505.JFOP23558.fep01-app.kolumbus.fi@mta.imail.kolumbus.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We should probably also not to try to boot disabled cpus in smp_boot_cpus()...

--Mika


