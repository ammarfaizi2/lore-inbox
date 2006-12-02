Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759432AbWLBKZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759432AbWLBKZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759433AbWLBKZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:25:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2773 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1759432AbWLBKZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:25:19 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Ben Collins <ben.collins@ubuntu.com>, Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <20061202002116.GB7931@redhat.com>
References: <1164998179.5257.953.camel@gullible>
	 <20061201185657.0b4b5af7@localhost.localdomain>
	 <1165001705.5257.959.camel@gullible>
	 <20061201195337.39ed9992@localhost.localdomain>
	 <1165006694.5257.968.camel@gullible>  <20061202002116.GB7931@redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 02 Dec 2006 11:25:16 +0100
Message-Id: <1165055116.3233.144.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 19:21 -0500, Dave Jones wrote:
> On Fri, Dec 01, 2006 at 03:58:14PM -0500, Ben Collins wrote:
>  > On Fri, 2006-12-01 at 19:53 +0000, Alan wrote:
>  > > > > The whole approach of using filp_open() not the firmware interface
>  > > > > is horribly ugly and does not belong mainstream. 
>  > > > 
>  > > > What about the point that userspace (udev, and such) is not available
>  > > > when DSDT loading needs to occur? Init hasn't even started at that
>  > > > point.
>  > > 
>  > > Does that change the fact it is ugly ?
>  > 
>  > No, but it does beg the question "how else can it be done"?
>  > 
>  > Distros need a way for users to add a fixed DSDT without recompiling
>  > their own kernels.
> 
> There already is a way. It's called beating up the braindead bios authors,
> and pressuring motherboard vendors to push out updates.

and it includes pointing them at the linux-ready firmware developer kit
(URL in sig) so that it's really easy for them to test Linux with their
bios. 

If you or anyone else experience bios horkage that's not caught, please
let us know, so that we can add tests....

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

