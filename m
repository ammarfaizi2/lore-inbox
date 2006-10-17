Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWJQVAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWJQVAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWJQVAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:00:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:24778 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750839AbWJQVAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:00:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f0SynlrY945n0otCYMm3cneAQYVn75AMn9H0SSio0TyB72jesfoPJ4BQf/uQPIVTLhqRuKw34nmulA3xym6DamfFvb44Ibf9m1AKfLJ0hTmR6kjaHIed0/OSGhmoAcnHWP5YkYp1LzR7d8gVey+oA/SACFtTJ+O+8kVVtsMvZk4=
Message-ID: <8413367b0610171400j2ae2c7b1p9f193d5e33e58581@mail.gmail.com>
Date: Tue, 17 Oct 2006 23:00:51 +0200
From: grfgguvf@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Re: Invalid PBLK length for athlon XP-M on Asus laptop
Cc: acpi-devel@lists.sourceforge.net, willy@debian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20030823173423.GQ18834@parcelfarce.linux.theplanet.co.uk>
References: <20030823173423.GQ18834@parcelfarce.linux.theplanet.co.uk>,
<20030823125812.GC913@renditai.milesteg.arr>
Newsgroups: linux.kernel

On Aug 23 2003, 7:42 pm, Matthew Wilcox <willy@debian.org> wrote:
> On Sat, Aug 23, 2003 at 02:58:12PM +0200, Daniele Venzano wrote:
> > I checked
> > dmesg with acpi debugging turned on (full dmesg is attached), and I
> > found these:
> >
> > [...]
> > ACPI: Fan [FAN0] (on)
> > acpi_processor-1626 [30] acpi_processor_get_inf: Invalid PBLK length [5]
>
> This is a bug in your ACPI bios, you need a vendor update.  We tried
> fixing this but it broke a number of laptops, so we had to revert it.

And years later... I just got this "Invalid PBLK length [5]" error
message as well, first time ever, when first booting 2.6.18. I never
got it with 2.6.17 or any earlier kernel. My BIOS or any settings
didn't change.

Now this is a desktop so ACPI is not very important to me but is this
possibly a regression?

> --
> "It's not Hollywood.  War is real, war is primarily not about defeat or
> victory, it is about death.  I've seen thousands and thousands of dead bodies.
> Do you think I want to have an academic debate on this subject?" -- Robert Fisk

-- Grifeg
