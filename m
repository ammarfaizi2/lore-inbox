Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVCIMGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVCIMGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVCIMGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:06:16 -0500
Received: from [202.125.86.130] ([202.125.86.130]:17880 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262360AbVCIMFn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:05:43 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: "remap_page_range" compile ERROR
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Wed, 9 Mar 2005 17:35:18 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348113A4897@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: "remap_page_range" compile ERROR
Thread-Index: AcUkoEMLthoc5dUPQxuu51Qk7kMe7A==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: <arjan@infradead.org>, <alan@lxorguk.ukuu.org.uk>, <martin.frey@scs.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I am running Redhat 9 Linux.
I have problem with compiling the i810fb driver downloaded from
Sourceforge site. I have D/W the i810fb patch
"linux-i810fb-0.0.35.tar.bz2".

When I run the make modules I get the following ERROR

i810_main.c: 643: warning: passing arg 1 of 'remap_page_range_R2baf18f2'
makes pointer from integer without a cast
i810_main.c: 643: incompatible type for argument 4 of
'remap_page_range_R2baf18f2'
i810_main.c: 643: too few arguments to function
'remap_page_range_R2baf18f2'
Make[3]: *** [I810_main.c] Error 1
........
......

The call to "remap_page_range()" is as follows:-

return (io_remap_page_range(vma->vm_start, off, vma->vm_end -
vma->vm_start, vma->vm_page_prot)) ? -EAGAIN : 0;


Please suggest me what could be the problem.

Regards,
Mukund jampala




