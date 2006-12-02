Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161992AbWLBAVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161992AbWLBAVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 19:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162007AbWLBAVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 19:21:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161992AbWLBAVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 19:21:20 -0500
Date: Fri, 1 Dec 2006 19:21:16 -0500
From: Dave Jones <davej@redhat.com>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
Message-ID: <20061202002116.GB7931@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ben Collins <ben.collins@ubuntu.com>,
	Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Eric Piel <eric.piel@tremplin-utc>
References: <1164998179.5257.953.camel@gullible> <20061201185657.0b4b5af7@localhost.localdomain> <1165001705.5257.959.camel@gullible> <20061201195337.39ed9992@localhost.localdomain> <1165006694.5257.968.camel@gullible>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165006694.5257.968.camel@gullible>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 03:58:14PM -0500, Ben Collins wrote:
 > On Fri, 2006-12-01 at 19:53 +0000, Alan wrote:
 > > > > The whole approach of using filp_open() not the firmware interface
 > > > > is horribly ugly and does not belong mainstream. 
 > > > 
 > > > What about the point that userspace (udev, and such) is not available
 > > > when DSDT loading needs to occur? Init hasn't even started at that
 > > > point.
 > > 
 > > Does that change the fact it is ugly ?
 > 
 > No, but it does beg the question "how else can it be done"?
 > 
 > Distros need a way for users to add a fixed DSDT without recompiling
 > their own kernels.

There already is a way. It's called beating up the braindead bios authors,
and pressuring motherboard vendors to push out updates.

		Dave

-- 
http://www.codemonkey.org.uk
