Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUHQKBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUHQKBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 06:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUHQKBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 06:01:18 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:28584 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264726AbUHQKBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 06:01:16 -0400
Date: Tue, 17 Aug 2004 10:58:56 +0100
From: Dave Jones <davej@redhat.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lhms-devel] Making hotremovable attribute with memory section[0/4]
Message-ID: <20040817095856.GA19243@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Yasunori Goto <ygoto@us.fujitsu.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <1092699350.1822.43.camel@nighthawk> <1092702436.21359.3.camel@localhost.localdomain> <20040816214017.77A3.YGOTO@us.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816214017.77A3.YGOTO@us.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 10:15:51PM -0700, Yasunori Goto wrote:
 > > Consider
 > > - Video capture
 > > - AGP Gart
 > > - AGP based framebuffer (intel i8/9xx)
 > 
 > I didn't consider deeply about this, because usually
 > enterprise server doesn't need Video capture feature or AGP.

AMD64's IOMMU is implemented using the AGP GART.
This feature is certainly used in server environments.

		Dave

