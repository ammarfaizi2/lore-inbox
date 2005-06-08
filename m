Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVFHRfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVFHRfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVFHRfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:35:43 -0400
Received: from fmr20.intel.com ([134.134.136.19]:5805 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261398AbVFHRfW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:35:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Penance PATCH] PCI: clean up the MSI code a bit
Date: Wed, 8 Jun 2005 10:34:10 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408D8DB89@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Penance PATCH] PCI: clean up the MSI code a bit
Thread-Index: AcVsTQ2W6ZYujb+bTUyeSqdsTTQzXQAAHQXg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Grant Grundler" <grundler@parisc-linux.org>, "Andi Kleen" <ak@suse.de>
Cc: "Greg KH" <gregkh@suse.de>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <linux-kernel@vger.kernel.org>, "Roland Dreier" <roland@topspin.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Vasquez" <andrew.vasquez@qlogic.com>,
       "Jeff Garzik" <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>
X-OriginalArrivalTime: 08 Jun 2005 17:34:12.0521 (UTC) FILETIME=[48D7C190:01C56C50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 08, 2005 10:15 AM Grant Grundler wrote:
> > I disagree it should stay as it is. Basically you are trading
> > a bit less complexity in Infiniband now for a lot of code
everywhere.
>
>It's not just infiniband. It's tg3 and e1000 as well.

MSI-X will outpace MSI in future. In my opinion, enabling MSI by default
is a short-term solution. Again, this is just my opinion.

Thanks,
Long
