Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVJLJBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVJLJBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 05:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVJLJBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 05:01:14 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:56964 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932407AbVJLJBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 05:01:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:User-Agent;
  b=VWrGIYwmB1e7TgpqK3d5pGmmrwj0YwVXKQnFo5fIf4Yq1uIalimIdALvxM1/kxp9iaEN/sm9DNEsJtmYfEs7PKcE6rq6DYUoPebfbUsM+vAM6lpzmSV4irdX3P3qRWWb7/l0KUgq4uVHKJTQ+84CKksyH9VMnjlAFAfssHKEAbo=  ;
Date: Wed, 12 Oct 2005 10:45:33 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: 2.6.14-rc4 echi_hcd hangs machine
Message-ID: <20051012084533.GB26865@gollum.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
   I tried to boot 14-rc4 yesterday but it fails when it reaches the init code
   forthe usb host controllers und freezes the machine totally:
   
<snip>
   [4294687.294000] usb usb3: Manufacturer: Linux 2.6.14-rc4 uhci_hcd
   [4294687.300000] usb usb3: SerialNumber: 0000:00:1d.2
   [4294687.321000] hub 3-0:1.0: USB hub found
   [4294687.326000] hub 3-0:1.0: 2 ports detected
   [4294689.363000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low)	-> IRQ 20
   [4294689.372000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
   [4294689.378000] ehci_hcd 0000:00:1d.7: debug port 1
   <EOF>
</snip>

This happens with rc3 too so I thought it had something in common with this bug:
http://bugzilla.kernel.org/show_bug.cgi?id=5350 but it doesn't seem so. I've got
USB debugging enabled but the above is all you get over the serial console. The
rc? series don't have a kernel debugger so is there any other way to debug this?

Regards,
		Boris.

   

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
