Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVEZXab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVEZXab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVEZXab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:30:31 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:20666 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261846AbVEZXaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:30:24 -0400
Date: Fri, 27 May 2005 01:30:21 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050526233021.GA26794@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4847F-8q-23@gated-at.bofh.it> <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org> <4295005F.nail2KW319F89@burner> <8E909B69-1F19-4520-B162-B811E288B647@mac.com> <42962180.6080800@tmr.com> <ED51E7F7-FB05-4812-AFE0-0CD93D07439F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED51E7F7-FB05-4812-AFE0-0CD93D07439F@mac.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005, Kyle Moffett wrote:

> I don't use the three-number made-up SCSI-over-USB IDs that Joerg was
> complaining about being unavailable.  I have mine set up based on the
> UUID of the  burner.  I'm sorry for being unclear, but my objection is
> to his desire to expose  the SCSI IDs to userspace as the primary
> naming scheme, when said SCSI IDs are  frequently just made up by the
> kernel for USB devices, etc.

Given that I know the SCSI IDs of every single device I install, am not
using SCAM, I don't object to using SCSI IDs, unfortunately, SCSI CD or
DVD writers are rare and costly - I'd prefer them over ATAPI every day
since I take one PCI device to connect like half a dozen narrow SCSI
devices. ATAPI is so wasteful. And I have bought SCSI for as long as
somewhat up-to-date devices were available.

Things get interesting though with ATAPI, ATAPICAM, ide-scsi, ide-cd and
all sorts of interfaces since probing various busses is something that
requires user intervention or trial & error to list _all_ devices in
different buses, and drives have unlogical bus numbers (seen these on
FreeBSD), or more generally, when cdrecord tries to coerce a device
numbering scheme on devices that are not enumerated, or devices that are
hotplug with device numbers changing with every plug-in action, or
whatever.

-- 
Matthias Andree
