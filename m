Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbTJUAIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTJUAIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:08:14 -0400
Received: from aneto.able.es ([212.97.163.22]:2474 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263004AbTJUAIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:08:12 -0400
Date: Tue, 21 Oct 2003 02:08:10 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI vs ServerWorksLE in 2.4.23-pre
Message-ID: <20031021000810.GG7429@werewolf.able.es>
References: <20031020234855.GC7429@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031020234855.GC7429@werewolf.able.es> (from jamagallon@able.es on Tue, Oct 21, 2003 at 01:48:55 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.21, J.A. Magallon wrote:
> Hi all...
> 
> I have discovered a little proble with ACPI. If I enable ACPI in a SuperMicro
> P3TDLE the kernel does not see the 64 bit PCI bus (bus number 1).
> 
> It looks the same in -pre5 and -pre7.
> The dmesg+lspci info that I have collected is at
> http://giga.cps.unizar.es/~magallon/linux/acpi/
> They are dmesg's for pre5 and pre7, just with HT_ONLY (and ACPI disabled in
> -pre7, so as it is an SMP kernel I just get ACPI_BOOT), and with ACPI
> enabled. There is also the diff between -pre7 and -pre7-acpi.
> 

I have added the output of dmidecode (dmi.txt)...

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre7-jam2 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
