Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161334AbWLAU6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWLAU6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWLAU6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:58:18 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:4553 "EHLO adelie.ubuntu.com")
	by vger.kernel.org with ESMTP id S1161334AbWLAU6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:58:17 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Ben Collins <ben.collins@ubuntu.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <20061201195337.39ed9992@localhost.localdomain>
References: <1164998179.5257.953.camel@gullible>
	 <20061201185657.0b4b5af7@localhost.localdomain>
	 <1165001705.5257.959.camel@gullible>
	 <20061201195337.39ed9992@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2006 15:58:14 -0500
Message-Id: <1165006694.5257.968.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 19:53 +0000, Alan wrote:
> > > The whole approach of using filp_open() not the firmware interface
> > > is horribly ugly and does not belong mainstream. 
> > 
> > What about the point that userspace (udev, and such) is not available
> > when DSDT loading needs to occur? Init hasn't even started at that
> > point.
> 
> Does that change the fact it is ugly ?

No, but it does beg the question "how else can it be done"?

Distros need a way for users to add a fixed DSDT without recompiling
their own kernels.
