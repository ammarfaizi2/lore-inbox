Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUG2RGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUG2RGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUG2RD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:03:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45748 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264919AbUG2RD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:03:27 -0400
Subject: Re: [ACPI][2.6.8-rc2-bk #] - ACPI shutdown problems on IBM
	Thinkpads (T42)
From: Vernon Mauery <vernux@us.ibm.com>
To: David Weinehall <tao@debian.org>
Cc: Shawn Starr <shawn.starr@rogers.com>, "'Brown, Len'" <len.brown@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729064338.GF22472@khan.acc.umu.se>
References: <29AC424F54821A4FB5D7CBE081922E400131B410@hdsmsx403.hd.intel.com>
	 <000301c47518$d6784e50$0200080a@panic>
	 <20040729064338.GF22472@khan.acc.umu.se>
Content-Type: text/plain
Message-Id: <1091120589.14718.4.camel@bluerat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 10:03:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest (acpi-20040715) ACPI patch against 2.6.7/2.6.8-rc2 works on
my T40 to bring back ACPI  interrupts after suspend/resume.  I don't
know if these will apply to the bk tree or not.  It also makes it so
other buttons besides the power button can wake up the machine (like the
Fn button).

--Vernon

On Wed, 2004-07-28 at 23:43, David Weinehall wrote:
> On Wed, Jul 28, 2004 at 11:05:00PM -0400, Shawn Starr wrote:
> > 
> > I'll keep looking for patches as you get time.
> > 
> > I appreciate your help.
> 
> Disable APIC support and shutdown will work.
> 
> Meanwhile, has anyone solved the problem with the Thinkpad-keys after
> a suspend/resume?  Volume keys still work, as does the brightness keys,
> but Fn+F4 for suspend doesn't (manual suspend still works), and tpb
> doesn't see any of the Thinkpad specific keypresses any longer
> ("Access IBM", Fn+Fx, etc), not even if I restart tpb, and
> /proc/interrupts:acpi indicates that interrups are not working for ACPI
> any longer.  All other interrupts seem to function properly, and I have
> both patches from [1] applied.
> 
> [1] http://bugme.osdl.org/show_bug.cgi?id=2643
> 
> 
> Regards: David Weinehall

