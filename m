Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbUK3VQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUK3VQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUK3VQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:16:29 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:24380 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S262308AbUK3VQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:16:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Walking all the physical memory in an x86 system
Date: Tue, 30 Nov 2004 14:16:22 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C205805721@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Walking all the physical memory in an x86 system
Thread-Index: AcTXAjDHLuWZly2fQaWRo5DnxwOYEAAH1tOg
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Nov 2004 21:16:23.0382 (UTC) FILETIME=[D82B3760:01C4D721]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan Engelhardt
Sent: Tuesday, November 30, 2004 9:10 AM
To: Hanson, Jonathan M
Cc: linux-kernel@vger.kernel.org
Subject: RE: Walking all the physical memory in an x86 system

>>dd_rescue /dev/mem copyofmem
>
>I'm not sure what dd_rescue is as I've never heard of
>it. However, I don't think such an operation can be done from userspace
>because I need the physical addresses of memory not the virtual ones.

/dev/mem *is* physical.

[Jon M. Hanson] I can read /dev/mem from a userspace application as root
with no problems and print out what it sees. However, things are not so
simple from a kernel module as I just can't call open() and read() on
/dev/mem because no such functions are exported from the kernel. Is
there a way to read the contents of /dev/mem from a kernel module?


