Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVEANmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVEANmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 09:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVEANmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 09:42:13 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:37263 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261616AbVEANlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 09:41:49 -0400
Message-ID: <4274DC95.6080208@ens-lyon.org>
Date: Sun, 01 May 2005 15:41:41 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, "Yu, Luming" <luming.yu@intel.com>
Subject: Re: 2.6.12-rc3-mm2: ACPI problems
References: <20050430164303.6538f47c.akpm@osdl.org> <200505011456.38744.rjw@sisk.pl>
In-Reply-To: <200505011456.38744.rjw@sisk.pl>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki a écrit :
> Hi,
> 
> On Sunday, 1 of May 2005 01:43, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/
> 
> 
> I have two ACPI-related problems with this kernel (they have also been present
> in the previous -mm, so please treat this report as a "the issue is still there" kind
> of thing):

I'm also seeing a (small) problem with ACPI for a few -mm kernels
(at least since -rc2-mm2, IIRC).
I don't have a /proc/acpi/button/ anymore.
My computer is a Compaq Evo N600c laptop.
ACPI is generally working great here.

In 2.6.12-rc3, I have:
/proc/acpi/button/lid/C1A4/info
/proc/acpi/button/lid/C1A4/state
/proc/acpi/button/power/PWRF/info
/proc/acpi/button/sleep/C1A3/info
Nothing in rc3-mm1 (even no /proc/acpi/button/ directory).

I didn't find any interesting difference between dmesg from rc3 and
rc3-mm1. Both show these lines:
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C1A3]
ACPI: Lid Switch [C1A4]

Any idea ?

Thanks
Brice
