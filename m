Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVCXPRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVCXPRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVCXPRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:17:10 -0500
Received: from fmr19.intel.com ([134.134.136.18]:8579 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262558AbVCXPQa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:16:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Pcihpd-discuss] RE: [RFC/Patch 0/12] ACPI based root bridgehot-add
Date: Thu, 24 Mar 2005 07:16:00 -0800
Message-ID: <468F3FDA28AA87429AD807992E22D07E04AE1DD2@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Pcihpd-discuss] RE: [RFC/Patch 0/12] ACPI based root bridgehot-add
Thread-Index: AcUv/IawrektigZvT3O/aJyyPWt28QAg5siQ
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Tom Duffy" <tduffy@sun.com>, "Dely Sy" <dlsy@snoqualmie.dp.intel.com>
Cc: <gregkh@suse.de>, "Shah, Rajesh" <rajesh.shah@intel.com>, <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       <pcihpd-discuss@lists.sourceforge.net>,
       "Luck, Tony" <tony.luck@intel.com>,
       "Prasad Singamsetty" <Prasad.Singamsetty@sun.com>
X-OriginalArrivalTime: 24 Mar 2005 15:16:02.0402 (UTC) FILETIME=[6426FC20:01C53084]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 23, 2005 3:03 PM, Tom Duffy wrote:
> On Tue, 2005-03-22 at 19:13 -0800, Dely Sy wrote:
> > I just did a test of Rajesh's latest patch on 2.6.11.5 with
> > Wilcox's acpiphp rewrite and the following patch.  Hot-plug of 
> > PCI Express card worked fine on my i386 system

> I have updated to Wilcox's rewrite, Rajesh's stuff, and Dely's latest
> patch.  Still seeing these:

I forgot to mention that I used attention button to test hot-plug.  As 
mentioned in an earlier thread, I found problem in using CLI to do
powering-up and getting status when using acpiphp in my system.

I think the problem with getting the slot status and setting led status 
is that these information is hardware specific and there is no standard
ACPI method that the driver can call to do so. That may be the reason 
there is a acpiphp_ibm extension.

Does anyone use CLI successfully in their systems with acpiphp?

Thanks,
Dely
