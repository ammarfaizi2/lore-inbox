Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTFPSHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTFPSHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:07:42 -0400
Received: from fmr02.intel.com ([192.55.52.25]:22734 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264080AbTFPSHj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:07:39 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: e1000 performance hack for ppc64 (Power4)
Date: Mon, 16 Jun 2003 11:21:16 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D94C@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 performance hack for ppc64 (Power4)
Thread-Index: AcMzSuDMkewgo8NbQ/eWd2USmzVnawA6Bt3g
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Herman Dierks" <hdierks@us.ibm.com>, "David S. Miller" <davem@redhat.com>
Cc: <ltd@cisco.com>, <anton@samba.org>, <haveblue@us.ibm.com>,
       <dwg@au1.ibm.com>, <linux-kernel@vger.kernel.org>,
       "Nancy J Milliner" <milliner@us.ibm.com>,
       "Ricardo C Gonzalez" <ricardoz@us.ibm.com>,
       "Brian Twichell" <twichell@us.ibm.com>, <netdev@oss.sgi.com>
X-OriginalArrivalTime: 16 Jun 2003 18:21:16.0611 (UTC) FILETIME=[13787130:01C33434]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herman wrote:
> Its only the MTU 1500 case with non-TSO that we are 
> discussing here so copying a few bytes is really not a big 
> deal as the data is already in cache from copying into 
> kernel.  If it lets the adapter run at speed, thats what 
> customers want and what we need. Granted, if the HW could 
> deal with this we would not have to, but thats not the case 
> today so I want to spend a few CPU cycles to get best 
> performance. Again, if this is not done on other platforms, I 
> don't understand why you care.

I care because adding the arch-specific hack creates a maintenance issue
for me.

-scott

