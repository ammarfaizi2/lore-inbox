Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbTJOOdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 10:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTJOOdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 10:33:31 -0400
Received: from mx01.netapp.com ([198.95.226.53]:44452 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S263316AbTJOOd3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 10:33:29 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: [NFS] RE: [autofs] multiple servers per automount
Date: Wed, 15 Oct 2003 07:31:47 -0700
Message-ID: <482A3FA0050D21419C269D13989C6113020AC516@lavender-fe.eng.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [NFS] RE: [autofs] multiple servers per automount
Thread-Index: AcOS7dCC96WKq66jTF2sWh22fC38lQAOq38A
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Ian Kent" <raven@themaw.net>
Cc: "Joseph V Moss" <jmoss@ichips.intel.com>,
       "Ogden, Aaron A." <aogden@unocal.com>,
       "Mike Waychison" <Michael.Waychison@Sun.COM>,
       "autofs mailing list" <autofs@linux.kernel.org>,
       <nfs@lists.sourceforge.net>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent said:
> Do you think that the possible NFS port allocation problems
> should hold up this work or should it drive updates to NFS?

hi ian-

the port stuff has to be addressed at some point, but i don't
think you should wait for it, because it is behind a long queue
of other RPC work (like Kerberos for Linux NFS) that has a
higher priority.  also, there are other patches that partially
address this limitation, and certainly those will be used by
the desparate few who need it now. :^)

IMHO.
