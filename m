Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752765AbVHGVOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbVHGVOz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbVHGVOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:14:54 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:48596 "EHLO mailbox.ines.ro")
	by vger.kernel.org with ESMTP id S1752765AbVHGVOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:14:54 -0400
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: luming.yu@intel.com, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8
Organization: iNES Group
Date: Mon, 08 Aug 2005 00:14:43 +0300
Message-Id: <1123449283.2549.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-7) 
Content-Transfer-Encoding: 8bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 1.6.2 on MailBox.iNES.RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

În data de Du, 07-08-2005 la 11:47 -0700, Linus Torvalds a scris:
> Luming Yu:
>   [ACPI] revert Embedded Controller to polling-mode by default (ala 2.6.12)
>   [ACPI] CONFIG_ACPI_HOTKEY is now "n" by default

IMHO you really need then to make acpi_specific_hotkey the default or at
least mention it in the release notes or you'll have tons of people
screaming that the specific module does not work anymore.
I found out about it after my toshiba_acpi module stopped working and I
noticed a small change in the development acpi tree documentation
mentioning acpi_specific_hotkey ...

-- 
Cioby


