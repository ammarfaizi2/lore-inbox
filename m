Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271003AbTHFUWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271373AbTHFUWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:22:45 -0400
Received: from bozo.vmware.com ([65.113.40.130]:50960 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S271003AbTHFUWi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:22:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6] Perl weirdness with ext3 and HTREE
Date: Wed, 6 Aug 2003 13:22:34 -0700
Message-ID: <68F326C497FDB743B5F844B776C9B146097700@pa-exch4.vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6] Perl weirdness with ext3 and HTREE
Thread-Index: AcNcG9lY+ABvtJP8T+ubyOqrv4faQgAOrJ0g
From: "Christopher Li" <chrisl@vmware.com>
To: <azarah@gentoo.org>
Cc: "KML" <linux-kernel@vger.kernel.org>, <akpm@digeo.com>,
       <adilger@clusterfs.com>, <ext3-users@redhat.com>,
       <x86-kernel@gentoo.org>
X-OriginalArrivalTime: 06 Aug 2003 20:22:35.0097 (UTC) FILETIME=[78DA8490:01C35C58]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin Schlemmer [mailto:azarah@gentoo.org]
> Sent: Tuesday, August 05, 2003 12:23 PM
> To: Christopher Li
> Cc: KML; akpm@digeo.com; adilger@clusterfs.com; ext3-users@redhat.com;
> x86-kernel@gentoo.org
> Subject: Re: [2.6] Perl weirdness with ext3 and HTREE
> 
> 
> On Tue, 2003-08-05 at 20:28, Christopher Li wrote:
> > I can take a look at it.
> > 
> > Is there any way to reproduce this bug without installing the
> > whole gentoo? It would be nice if I can just download some
> > package to make it happen.
> > 
> 
> Just grab the perl source, if you want, I can mail you the ebuild that
> should give some direction in how to compile it, or grab your local
> .spec, configure it (maybe with install location not in /), and then
> just compile and finally install to a ext3 FS with HTREE enabled. 
> Usually over here, it keeps on leaving an invalid entry to
> ..usr/share/man/man3/Hash::Util.tmp.
> 

I am running 2.6-test2 kernel. Download the perl 5.8.0 (stable.tar.gz).
./Configure --prefix=/mnt/hdc3; make; make install.

It did not happen for me. Hash::Util.3 was installed correctly.
(Of course, I did turn on directory index)

Can you send me more infomation how you build the perl package
and install it? I guess I have to do more gentoo like step to duplicate
it :-)

Thanks

Chris



