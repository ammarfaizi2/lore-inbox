Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVCRTal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVCRTal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVCRTak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:30:40 -0500
Received: from fmr18.intel.com ([134.134.136.17]:37866 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262009AbVCRTa2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:30:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]PCIErrorRecovery)
Date: Fri, 18 Mar 2005 11:29:43 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408132A53@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]PCIErrorRecovery)
Thread-Index: AcUrRNpiYyerkShDQ2q0r5aeKrJxEgAq4naA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "Paul Mackerras" <paulus@samba.org>,
       "Hidetoshi Seto" <seto.hidetoshi@jp.fujitsu.com>,
       "Greg KH" <greg@kroah.com>, <ak@muc.de>,
       "linuxppc64-dev" <linuxppc64-dev@ozlabs.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 18 Mar 2005 19:29:44.0610 (UTC) FILETIME=[D6D11820:01C52BF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 17, 2005 2:58 PM Benjamin Herrenschmidt wrote:
> Does the link side of PCIE provides a way to trigger a hard reset of
the
> rest of the card ? If not, then it's dodgy as there may be no way to
> consistently "reset" the card if it's in a bad state. 

The PCI Express spec does not make it clear of whether an in-band
mechanism, called a hot-reset, triggers a hard reset of the rest of the
card. I agree that if not, then it's dodgy.

Thanks,
Long
