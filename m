Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUI0SJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUI0SJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUI0SJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:09:40 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:24970 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266896AbUI0SJW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:09:22 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Mon, 27 Sep 2004 13:09:17 -0500
User-Agent: KMail/1.6.2
Cc: Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409270112.29422.dtor_core@ameritech.net> <20040927095348.A29594@unix-os.sc.intel.com>
In-Reply-To: <20040927095348.A29594@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409271309.17756.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 11:53 am, Keshavamurthy Anil S wrote:
>         I just wanted to have a single function i.e setup_sys_fs_device_files() for both
> creating and removing sysfs files.

Ah, I see... Makes sense, especially when there is additional logic involved
in creating some of the attributes, which is the case with ACPI.

-- 
Dmitry
