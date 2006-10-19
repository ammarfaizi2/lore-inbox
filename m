Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946668AbWJSXVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946668AbWJSXVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946667AbWJSXVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:21:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946664AbWJSXVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:21:31 -0400
Date: Thu, 19 Oct 2006 19:20:59 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: SMP broken on pre-ACPI machine.
Message-ID: <20061019232059.GA2409@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Len Brown <lenb@kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org
References: <20061018222433.GA4770@redhat.com> <200610190133.40581.len.brown@intel.com> <20061019191644.GE26530@redhat.com> <20061019201116.GG26530@redhat.com> <1161296239.17335.151.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161296239.17335.151.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 11:17:19PM +0100, Alan Cox wrote:
 > Ar Iau, 2006-10-19 am 16:11 -0400, ysgrifennodd Dave Jones:
 > > On Thu, Oct 19, 2006 at 03:16:44PM -0400, Dave Jones wrote:
 > > 
 > >  > Why smp_found_config isn't set in that guys configuration is a mystery to me,
 > >  > as his MPS tables look sane..
 > >  > 
 > >  > MP Table:
 > >  > #	APIC ID	Version	State		Family	Model	Step	Flags
 > >  > #	 0	 0x10	 BSP, usable	 6	 2	 1	 0x0381
 > 
 > Isn't that an "overdrive" ? if so it isn't supposed to be SMP capable

I don't think so. The only overdrive that fitted in a socket 8 board
was a PPro->PentiumII thing, which would be model 3 stepping 2 as far
as I can figure out from a lengthy archeology trip through developer.intel.com.

There were also some Socket8->Socket370 convertors, but afaik they just passed
through the family/model/stepping of whatever was plugged into them.

	Dave

-- 
http://www.codemonkey.org.uk
