Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266601AbTGKEIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 00:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266602AbTGKEIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 00:08:15 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:4356 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266601AbTGKEIO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 00:08:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Pcihpd-discuss] Re: PCI Hot-plug driver patch for 2.5.74 kernel
Date: Thu, 10 Jul 2003 23:22:55 -0500
Message-ID: <8C91B010B3B7994C88A266E1A72184D301AA0451@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Pcihpd-discuss] Re: PCI Hot-plug driver patch for 2.5.74 kernel
Thread-Index: AcNHTaluGgWKzHlaT5CzFXi/0Bnt9gAFcRLw
From: "Zink, Dan" <dan.zink@hp.com>
To: "Greg KH" <greg@kroah.com>, "Dely Sy" <dlsy@unix-os.sc.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <pcihpd-discuss@lists.sourceforge.net>,
       <tony.luck@intel.com>
X-OriginalArrivalTime: 11 Jul 2003 04:22:55.0593 (UTC) FILETIME=[1A0DF590:01C34764]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've looked at the patch a bit and would prefer that it not
be applied as is.  In particular, it seems to remove proper
detection for features that are in the driver today.  For example,
the decisions that are made off the subsytem ID...

Would it be possible to split this into smaller patches that
each do one particular thing?

Regards,
Dan  

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Thursday, July 10, 2003 8:39 PM
> To: Dely Sy
> Cc: linux-kernel@vger.kernel.org; 
> pcihpd-discuss@lists.sourceforge.net; tony.luck@intel.com
> Subject: [Pcihpd-discuss] Re: PCI Hot-plug driver patch for 
> 2.5.74 kernel
> 
> 
> Thanks, I'm going to wait to see what the HP/Compaq people 
> have to say about this patch before applying it.
> 
> greg k-h
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book. 
> www.parasoft.com/bulletproofapps1 
> _______________________________________________
> Pcihpd-discuss mailing list Pcihpd-discuss@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/pcihpd-discuss
> 
