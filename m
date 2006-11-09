Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424036AbWKITvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424036AbWKITvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424106AbWKITvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:51:35 -0500
Received: from dvhart.com ([64.146.134.43]:26557 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1424036AbWKITve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:51:34 -0500
Message-ID: <455386B6.7000300@mbligh.org>
Date: Thu, 09 Nov 2006 11:51:18 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.19-rc5-mm1 (compile failure, USB ohci-hcd.c)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




  CC [M]  drivers/usb/host/ohci-hcd.o
In file included from drivers/usb/host/ohci-hcd.c:949:
drivers/usb/host/ohci-ppc-of.c: In function `ohci_hcd_ppc_of_init':
drivers/usb/host/ohci-ppc-of.c:272: warning: int format, different type 
arg (arg 2)
drivers/usb/host/ohci-ppc-of.c:272: warning: int format, different type 
arg (arg 3)
drivers/usb/host/ohci-ppc-of.c: At top level:
drivers/usb/host/ohci-ppc-of.c:282: error: redefinition of `__inittest'
drivers/usb/host/ohci-pci.c:252: error: `__inittest' previously defined here
drivers/usb/host/ohci-ppc-of.c:282: error: redefinition of `init_module'
drivers/usb/host/ohci-pci.c:252: error: `init_module' previously defined 
here
drivers/usb/host/ohci-ppc-of.c:283: error: redefinition of `__exittest'
drivers/usb/host/ohci-pci.c:260: error: `__exittest' previously defined here
drivers/usb/host/ohci-ppc-of.c:283: error: redefinition of `cleanup_module'
drivers/usb/host/ohci-pci.c:260: error: `cleanup_module' previously 
defined here
make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1
make[2]: *** [drivers/usb/host] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2
11/09/06-04:11:29 Build the modules. Failed rc = 2
11/09/06-04:11:29 build: kernel build Failed rc = 1


Full log: http://test.kernel.org/abat/60757/debug/test.log.0
config: http://test.kernel.org/abat/60757/build/dotconfig
