Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUITSeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUITSeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 14:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUITSeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 14:34:18 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:60801 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267176AbUITSdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 14:33:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Mon, 20 Sep 2004 13:33:42 -0500
User-Agent: KMail/1.6.2
Cc: "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920093532.D14208@unix-os.sc.intel.com>
In-Reply-To: <20040920093532.D14208@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409201333.42857.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 September 2004 11:35 am, Keshavamurthy Anil S wrote:
> This patch support /sys/firmware/acpi/eject interface where in 
> the ACPI device say "LSB0" can be ejected by echoing "\_SB.LSB0" > 
> /sys/firmware/acpi/eject
> 

I wonder if eject should be an attribute of an individual device and visible
only when device can be ejected. Reading from it could show eject level
(_EJ0/_EJ3 etc).

-- 
Dmitry
