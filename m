Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVCEUVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVCEUVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVCEUR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:17:28 -0500
Received: from secure.htb.at ([195.69.104.11]:12815 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S261253AbVCEUGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 15:06:16 -0500
Date: Sat, 5 Mar 2005 21:05:57 +0100
From: Richard Mittendorfer <jkerdawn@yahoo.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error messages with ACPI
Message-Id: <20050305210557.26d7fa28.jkerdawn@yahoo.com>
In-Reply-To: <33065.24.85.238.99.1110046181.squirrel@24.85.238.99>
References: <33065.24.85.238.99.1110046181.squirrel@24.85.238.99>
X-Mailer: Sylpheed version 0.9.99-gtk2-20041024 (GTK+ 2.4.14; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1D7fXH-000227-00*2p.z0u/rAVs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Mina Nozar <nozarm@triumf.ca> (Sat, 5 Mar 2005 10:09:41
-0800 (PST)):
> Hi,

hi mina.

> [...]
> kernel:  ACPI-1133: *** Error: Method execution failed
> [\_SB_.BAT0._BST](Node dfe043c0), AE_AML_NO_RETURN_VALUE
> lastt message repeated 2 times
> last message repeated 4 times
> ...
> ...

(afaik) these are not critical - they come from the yout acpi bios.
these implementions are known to be bad. you can find more information
on the acpi homepage[1]. maybe you can fix this with a modifcated dsdt
from there - but i'm not sure if it's worth the work.

do you get valid entries in /proc/acpi and are your battery states ok?
then you most likely have no problem. on my old libretto i get tons of
them at bootup and sometimes when comming out of suspend.

however, if your logs get filled with those messages ... 

sl ritch.

[1] http://acpi.sourceforge.net/
