Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbTIVT7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTIVT7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:59:20 -0400
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:35590 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S263308AbTIVT7T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:59:19 -0400
From: Witold Krecicki <adasi@kernel.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SiI3112: problemes with shared interrupt line?
Date: Mon, 22 Sep 2003 21:59:12 +0200
User-Agent: KMail/1.5.9
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F6B3@mail-sc-6.nvidia.com> <1064260163.2414.3.camel@sort.fjase.net>
In-Reply-To: <1064260163.2414.3.camel@sort.fjase.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309222159.12643.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia pon 22. wrze¶nia 2003 21:49, Per Andreas Buer napisa³:
> On Mon, 2003-09-22 at 21:42, Allen Martin wrote:
> > There are two issues I know about:
> >
> > 1) Earlier versions of the Asus BIOS would program incorrect timing in
> > the nForce internal P2P bridge, causing failures with SI3112 under high
> > disk activity.  This is fixed in rev 1005 of their BIOS or later.
>
> I am running the latest (1006, I think) ASUS (this is a ASUS A7
> something Deluxe motherboard) BIOS revision.
>
> > 2) PCI interrupts getting put into edge triggered mode when ACPI/APIC are
> > enabled.  Andrew de Quincey said this should be fixed in 2.4.22, but I
> > haven't tested it myself (I have ACPI disabled on all my test systems). 
> > I did verify his patch on 2.6 when he first posted it, and it works.
>
> I've tried disabeling APIC - it did not help.
>
> I'll try 2.6.something tomorrow.
Try to disable both ACPI and APIC, it helped in my case.
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
