Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTLAQKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 11:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbTLAQKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 11:10:54 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:63939 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263846AbTLAQKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 11:10:52 -0500
X-Sender-Authentication: net64
Date: Mon, 1 Dec 2003 17:10:50 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem Report 2.4.23 ACPI and ASUS TRL-DLS
Message-Id: <20031201171050.4b7f5def.skraw@ithnet.com>
In-Reply-To: <1070181948.2663.6.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE00184CE53@hdsmsx402.hd.intel.com>
	<1070181948.2663.6.camel@dhcppc4>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2003 03:45:48 -0500
Len Brown <len.brown@intel.com> wrote:

> On Sat, 2003-11-29 at 12:10, Stephan von Krawczynski wrote:
> > Hello,
> > 
> > I just found out that enabling ACPI (kernel 2.4.23) on an ASUS TRL-DLS
> > board
> > leads to a failing boot, caused by not configuring the onboard scsi
> > aic
> > interfaces. In fact they are simply gone from the pci list (no
> > kidding).
> > Disabling ACPI leads to a perfectly working box with:
> 
> Did earlier 2.4 or 2.6 kernels with ACPI configured work properly on
> this box?

Hello Len,

sorry for delayed answer.
Actually I never tried 2.6 on this box. Regarding earlier 2.4 I can only tell
you that SuSE 9.0 kernel (some patched 2.4.21-whoeverdidwhatever) does not boot
either with acpi-enabled.

> Does the failing kernel do any better if you tell it to boot with
> "pci=noacpi"

Yes, works.

> or "noapic"?

No, does not work.

Hope that helps.

Regards,
Stephan
