Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTIHPo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbTIHPo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:44:58 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:37845 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262491AbTIHPoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:44:22 -0400
Date: Mon, 8 Sep 2003 08:42:34 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Sven Dowideit <svenud@ozemail.com.au>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-acpi <linux-acpi@intel.com>
Subject: Re: USB - UHCI not SMP capable? linux-2.6-test4
Message-ID: <20030908084234.B13225@beaverton.ibm.com>
References: <7F740D512C7C1046AB53446D3720017304AF12@scsmsx402.sc.intel.com> <1063050150.2977.17.camel@sven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1063050150.2977.17.camel@sven>; from svenud@ozemail.com.au on Tue, Sep 09, 2003 at 05:42:30AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 05:42:30AM +1000, Sven Dowideit wrote:
> ok , as I have not had any success with ACPI i have it turned off on all
> my computers. I added acpi=off to my boot parameters just in case, but
> USB is still non-functional.
> 
> sorry, that wasn't it

Did you try Duncan's patch:
 
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=106282603828913&w=2

The patch above applies to plain test4 with some offsets.

It fixed my problem (I havde UP, with slab debug on).

-- Patrick Mansfield
