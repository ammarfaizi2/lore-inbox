Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbTAOSVD>; Wed, 15 Jan 2003 13:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbTAOSVD>; Wed, 15 Jan 2003 13:21:03 -0500
Received: from fmr02.intel.com ([192.55.52.25]:26312 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266806AbTAOSVB> convert rfc822-to-8bit; Wed, 15 Jan 2003 13:21:01 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
Date: Wed, 15 Jan 2003 10:29:27 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E233@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK7MdQcXd/ejyckEdewWABQi2jYqABkOrbA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "William Lee Irwin III" <wli@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Jan 2003 18:29:28.0184 (UTC) FILETIME=[09AE8780:01C2BCC4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can these (MAX_IO_APICS, MAX_APICS) be moved to sub-arch too, instead of
replacing CONFIG NUMA by CONFIG NUMAQ?

Thanks,
-Venkatesh

> -----Original Message-----
> From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
> Sent: Monday, January 13, 2003 10:30 AM
> To: Protasevich, Natalie
> Cc: Pallipadi, Venkatesh; 'William Lee Irwin III'; Nakajima, 
> Jun; 'Christoph Hellwig'; 'James Cleverdon'; 'Linux Kernel'
> Subject: RE: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
> 
> 
> > I ran into a couple places where CONFIG_X86_NUMA is still 
> there (replaced
> > now with CONFIG_X86_NUMAQ), which disables following defines:
> 
> Yeah, I saw those the other day. Should probably be replaced with 
> CONFIG_NUMA ... I'll tweak them once I get the last dribbles of Summit
> pushed out to Linus.
> 
> Thanks,
> 
> M.
> 
> 
