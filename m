Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTDGOQA (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTDGOQA (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:16:00 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:45330 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263468AbTDGOP7 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:15:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: How to speed up building of modules?
Date: Mon, 7 Apr 2003 09:27:29 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106404744CC6@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to speed up building of modules?
Thread-Index: AcL7T/jtWlW1Sv3oQZuMYDPFmuJs7wBwXrTA
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Apr 2003 14:27:29.0913 (UTC) FILETIME=[D1FDAE90:01C2FD11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
On Fri, Apr 04, 2003 at 02:57:40PM +0600, Stephen Cameron wrote:
> Hi
> 
> I'm wondering if you guys know any tricks to speed up building
> of linux kernel modules.
[...]
In general I advice you to use:
$ make -C path/to/kernel/src SUBDIRS=$PWD modules
when building modules. 

Ok, thanks to everybody who replied.  I believe I've
got something that's going to work for me now and 
save us a lot of time.   Thanks.
-- steve
