Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTLAHao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTLAHan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:30:43 -0500
Received: from fmr04.intel.com ([143.183.121.6]:55953 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261309AbTLAHal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:30:41 -0500
Subject: Re: PROBLEM: ISDN
From: Len Brown <len.brown@intel.com>
To: idordic@alfakompjuter.hr
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE00184CEC5@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE00184CEC5@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1070263831.2517.10.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Dec 2003 02:30:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the system freezes on loading a module when ACPI is enabled,
but when booted with acpi=off or pci=noacpi it doesn't freeze,
then it may be an ACPI interrupt configuration issue.

if so, please file a bug with the details.

However, it sounds like you've got some sort of freeze issue (on unload)
even with ACPI disabled -- so chances are good that this is a
device-specific issue.

thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from dmidecode, available in /usr/sbin/, or
here:
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.

On Sun, 2003-11-30 at 06:21, Ivo Dordic wrote:
> System freezes on loading/uloading hisax module. (during booting up
> and
> down)
> 
> I have PIV 2.4 with HT and Intel board GBF, 512 MB RAM, 40 GB
> ExcelStor.
> 
> System is default SuSe 9 Pro installation.
> 
> When I turn acpi off on boot up system is getting up, but when I
> shutdown it freezes on unloading hisax module.
> 
> No messages by kernel and nothing works (keyboard, mouse) except reset
> and power buttons.
> 
> ISDN is PCI by Tekcomm (www.tekcomm.dk)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

