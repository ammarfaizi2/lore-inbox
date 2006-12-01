Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031761AbWLATfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031761AbWLATfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031757AbWLATfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:35:11 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:56002 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S1031758AbWLATfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:35:10 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Ben Collins <ben.collins@ubuntu.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <20061201185657.0b4b5af7@localhost.localdomain>
References: <1164998179.5257.953.camel@gullible>
	 <20061201185657.0b4b5af7@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2006 14:35:05 -0500
Message-Id: <1165001705.5257.959.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 18:56 +0000, Alan wrote:
> On Fri, 01 Dec 2006 13:36:19 -0500
> Ben Collins <ben.collins@ubuntu.com> wrote:
> 
> > I'd be willing to bet that most distros have this patch in their kernel.
> > One of those things we can't really live without.
> 
> This has been suggested various times before. 
> 
> | +Before you run away from customising your DSDT, you should note that
> | already +corrected tables are available for a fair amount of computers
> | on this web-page: +http://acpi.sf.net/dsdt
> 
> Generally without copyright permission from the owner of the copyrighted
> work in question to have it modified and redistributed.
> 
> The whole approach of using filp_open() not the firmware interface
> is horribly ugly and does not belong mainstream. 

What about the point that userspace (udev, and such) is not available
when DSDT loading needs to occur? Init hasn't even started at that
point.
