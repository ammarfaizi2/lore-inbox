Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbTJAPGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTJAPGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:06:53 -0400
Received: from lidskialf.net ([62.3.233.115]:39887 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262307AbTJAPGv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:06:51 -0400
From: Andrew de Quincey <adq@lidskialf.net>
To: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] p2b-ds blacklisted?
Date: Wed, 1 Oct 2003 16:05:11 +0100
User-Agent: KMail/1.5.3
References: <blen4v$a42$1@sea.gmane.org> <200310011516.45878.adq@lidskialf.net> <blepra$g94$1@sea.gmane.org>
In-Reply-To: <blepra$g94$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310011605.11943.adq@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 Oct 2003 3:53 pm, Sven Köhler wrote:
> > I'm sure I saw a comment somewhere saying the P2B-S was blacklisted
> > because of "bogus IRQ routing". It was in the blacklisting code, but I
> > can't remember where, or if it was 2.4 or 2.6.
>
> Well, the P2B-S is in blacklist.c in 2.4.22.
>
> What does the entry in blacklist.c mean? Does this entry mean acpi=ht is
> forced like the entry for the P2B-DS in dmi_scan.c?

Not sure.. I think it is likely to disable ACPI completely.

> Is this a hardwired problem on the Motherboard? Or might this be fixed
> with the latest BIOS?

It would be a problem with the DSDT code in the BIOS. It might be fixed in a 
later one. 

There have been lots of ACPI IRQ routing bugfixes (not all in the mainline 
kernel yet); maybe the P2B-S routing is solved by one of these, maybe not...

> I'd like to try ACPI on my P2B-DS anyway. I think there was an append
> line to disable ACPI IRQ Routing - was it acpi=pci?

pci=noacpi should do it I think.

