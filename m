Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUAMTET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbUAMTET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:04:19 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:22940 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265431AbUAMTER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:04:17 -0500
Subject: RE: Loading Pentium III microcode under Linux - catch 22!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Tigran Aivazian <tigran@veritas.com>, Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AE75@scsmsx402.sc.intel.com>
References: <7F740D512C7C1046AB53446D3720017304AE75@scsmsx402.sc.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074020440.30531.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 13 Jan 2004 19:00:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 18:40, Nakajima, Jun wrote:
> One issue with doing it in lilo or grub is that we need to apply
> microcode update to each (physical) CPU. So we need to change the
> current driver structure if we want to move it to the boot loader.

Not really. The boot loader loads the kernel and initrd image and runs
the kernel. The initrd is a file system which can contain things like
the microcode loader and the microcode sets, just like it can contain
anything else.


