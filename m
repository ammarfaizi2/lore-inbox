Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUFBMFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUFBMFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFBMEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:04:39 -0400
Received: from users.linvision.com ([62.58.92.114]:43749 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262194AbUFBMEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:04:01 -0400
Date: Wed, 2 Jun 2004 14:03:59 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Hamish Whittal <hamish@QEDux.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple CDR's on an IDE based system
Message-ID: <20040602120359.GB22648@harddisk-recovery.com>
References: <1086083663.925.114.camel@defender.QEDux.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086083663.925.114.camel@defender.QEDux.co.za>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 09:54:23AM +0000, Hamish Whittal wrote:
> I have a machine that has 3 CDRW's in it. I have tried many different
> configurations of these drives on various IDE controllers, but am still
> having some problems.
> 
> I will try to sketch the scenario:
> CDRW1 slave on controller with HDD
> CDRW2 as master on second on-board IDE controller
> CDRW3 as master on additional PCI IDE controller
> 
> (I have also tried adding 2 PCI IDE controllers, and putting each CDRW
> as master on each of these controllers, but I get the FIFO buffer
> dropping to 0% very soon after starting a write).

What kind of PCI controller was that? I've seen that kind of behaviour
with Promise IDE cards.

> My machine is a Debian linux IDE based machine. The specs of the machine
> are as follows:
> CPU      : Intel(R) Pentium(R) 4 CPU 2.80GHz
> 2 IDE controllers, single 120GB HDD.
> Additional PCI IDE controller

What are the *exact* specs: what kind of IDE controller, chipsets
revisions, etc. See the file REPORTING-BUGS in your kernel source tree.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
