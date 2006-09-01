Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWIADbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWIADbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWIADbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:31:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:58765 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750940AbWIADbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:31:23 -0400
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception
	code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Shaohua Li <shaohua.li@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>,
       "Moore, Robert" <robert.moore@intel.com>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1157078346.2782.24.camel@sli10-desk.sh.intel.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
	 <200608310248.29861.len.brown@intel.com>
	 <1157042913.7859.31.camel@keithlap>
	 <200608311707.00817.bjorn.helgaas@hp.com>
	 <1157073592.5649.29.camel@keithlap>
	 <1157078346.2782.24.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 31 Aug 2006 20:31:19 -0700
Message-Id: <1157081479.5649.40.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Also see   
> > http://sourceforge.net/mailarchive/forum.php? 
> > thread_id=15282420&forum_id=223
> > 
> > I don't claim this is the ACPI correct solution and am welcome to any 
> > input that fixes my issue: acpi_bus_find_driver returning the
> > incorrect 
> > driver for a given handle.    
> Then the issue is your device _CID returned PNP0C01 or PNP0C02. Is this
> intended? Can we change the BIOS?

  The spec talks about _HID for the memory device and that is ok but I
don't see any reference to required _CID. My _CID is listed as hex.  Can
I just convert it?

 Changing the bios is a little bit of a long shot at this point. 

Thanks,
  Keith 

