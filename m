Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWBQIPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWBQIPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 03:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWBQIPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 03:15:18 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:63977 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S932585AbWBQIPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 03:15:16 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYzmjtRlQ99tRRrRyG4ktqnnQy0Zw==
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43F585FD.8020802@bfh.ch>
Date: Fri, 17 Feb 2006 09:14:53 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>,
       "device-mapper development" <dm-devel@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] User-configurable HDIO_GETGEO for dm volumes
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 08:14:53.0433 (UTC) FILETIME=[3AFDCE90:01C6339A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<snip>

Just on a side note: I'm currently working on a patch to make disk
geometry information available through sysfs (for all those devices that
provide getgeo) and and extended patch to make it writable through the
same interface by introducing a setgeo function as a companion to getgeo.

Perhaps this'll make some of this easier...

