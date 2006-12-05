Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967567AbWLEGAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967567AbWLEGAO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967623AbWLEGAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:00:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:36912 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967567AbWLEGAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:00:12 -0500
Date: Mon, 4 Dec 2006 22:00:09 -0800
From: "Kurtis D. Rader" <krader@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives
Message-ID: <20061205060009.GB2323@us.ibm.com>
References: <4570CF26.8070800@scientia.net> <20061203011737.GA2729@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203011737.GA2729@us.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 17:17:37, Kurtis D. Rader wrote:
> I'm also experiencing silent data corruption on writes to SATA disks
> connected to a Nvidia controller (nForce 4 chipset). The problem is
> 100% reproducible. Details of my configuration (mainboard model, lspci,
> etc.) are near the bottom of this message. What follows is a summation
> of my findings.

Various suggestions (e.g., booting with "acpi=off") have either not helped
or have resulted in a system which won't boot.

Today I replaced the ASUS A8N (nVidia nForce 4 chipset) mainboard and
AMD Athlon 64 CPU with a Intel DP965LT (Intel 965 chipset) and E6600
Duo Core 2 CPU. The SATA disks and cables are unchanged. The case, power
supply, and video card are also unchanged. Not one of the previous tests
now results in corruption. 

If anyone (e.g., a nVidia employee) wants to pursue this and can provide
a meaningful action plan I'll be happy to install the problem components
in another case and attempt to gather additional diagnostic data.

-- 
Kurtis D. Rader, Linux level 3 support  email: krader@us.ibm.com
IBM Integrated Technology Services      DID: +1 503-578-3714
15300 SW Koll Pkwy, MS RHE2-O2          service: 800-IBM-SERV
Beaverton, OR 97006-6063                http://www.ibm.com
