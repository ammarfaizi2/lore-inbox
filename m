Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbSJYXxV>; Fri, 25 Oct 2002 19:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJYXxU>; Fri, 25 Oct 2002 19:53:20 -0400
Received: from fmr01.intel.com ([192.55.52.18]:26332 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261696AbSJYXxU>;
	Fri, 25 Oct 2002 19:53:20 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE70C8@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Robert Love <rml@tech9.net>, "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Fri, 25 Oct 2002 16:59:29 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RedHat 8.0 is using
	"Physical processor ID\t:"
	"Number of siblings\t:"
This implies they need to change it anyway, because 2.4-ac is
	"physical id\t:"
	"siblings\t:"

Jun
-----Original Message-----
From: Robert Love [mailto:rml@tech9.net]
Sent: Friday, October 25, 2002 2:54 PM
To: Nakajima, Jun
Cc: Alan Cox; 'Dave Jones'; 'akpm@digeo.com';
'linux-kernel@vger.kernel.org'; 'chrisl@vmware.com'; 'Martin J. Bligh'
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo


On Fri, 2002-10-25 at 17:50, Nakajima, Jun wrote:

> Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for
example,
> is already doing it:

But RedHat apparently is using siblings.  2.4-ac also uses siblings.
And I like "siblings" better so it wins in my opinion.

	Robert Love

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
