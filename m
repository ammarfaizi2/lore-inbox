Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbSKORfk>; Fri, 15 Nov 2002 12:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266601AbSKORfk>; Fri, 15 Nov 2002 12:35:40 -0500
Received: from dhcp80ff2399.dynamic.uiowa.edu ([128.255.35.153]:12416 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S266609AbSKORfi>;
	Fri, 15 Nov 2002 12:35:38 -0500
Date: Fri, 15 Nov 2002 11:42:34 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 bug - USB usbfs segvs processes
Message-ID: <20021115174234.GB2828@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another bug in 2.5.47, this time with USBFS.  When attempting to read
  /proc/bus/usb/drivers, the program reading the "file" terminates with
  a segmentation fault:
/proc/bus/pci:58$ cat devices 
Segmentation fault
$lspci
Segmentation fault

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"[The question of] copy protection has long been answered, and it's only
  a matter of months until more or less all CDs will be published with
  copy protection."  --"Ihr EMI Team" 
    http://www.theregister.co.uk/content/54/27960.html
