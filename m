Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbUK3QKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbUK3QKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUK3QKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:10:21 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:39097 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S262147AbUK3QJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:09:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Walking all the physical memory in an x86 system
Date: Tue, 30 Nov 2004 09:09:22 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C2057CA977@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Walking all the physical memory in an x86 system
Thread-Index: AcTW9Q/gAduUgQtfRQSv9hIlzC44zwAAXi8w
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Nov 2004 16:09:23.0591 (UTC) FILETIME=[F51E2970:01C4D6F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Jan Engelhardt [mailto:jengelh@linux01.gwdg.de] 
Sent: Tuesday, November 30, 2004 8:55 AM
To: Hanson, Jonathan M
Cc: linux-kernel@vger.kernel.org
Subject: Re: Walking all the physical memory in an x86 system

>	I've written a 2.4 kernel module where I'm trying to walk and
>record all of the physical memory contents in an x86 system. I have the
>following code fragment that does it but I suspect I'm missing a
portion
>of the memory:
>
>Is there a better way to record all of the contents of physical memory
>since what I have above doesn't seem to get everything?

Maybe something userspace based?

dd_rescue /dev/mem copyofmem


[Jon M. Hanson] I'm not sure what dd_rescue is as I've never heard of
it. However, I don't think such an operation can be done from userspace
because I need the physical addresses of memory not the virtual ones.

