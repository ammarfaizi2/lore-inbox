Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbULHSOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbULHSOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbULHR7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:59:20 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:32380 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S261288AbULHR4e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:56:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Figuring out physical memory regions from a kernel module
Date: Wed, 8 Dec 2004 10:54:23 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C205960153@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Figuring out physical memory regions from a kernel module
Thread-Index: AcTdTnA548u/aM0ER8+ZSogM1f0tzQAABYkQ
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Dec 2004 17:54:24.0460 (UTC) FILETIME=[F40878C0:01C4DD4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Wednesday, December 08, 2004 10:50 AM
To: Hanson, Jonathan M
Cc: linux-kernel@vger.kernel.org
Subject: Re: Figuring out physical memory regions from a kernel module

On Wed, 2004-12-08 at 10:44 -0700, Hanson, Jonathan M wrote:
> 	Is there a reliable way to tell from a kernel module (currently
> written for 2.4 but will need to work under 2.6 in the future) which
> regions of physical memory are actually available for the kernel and
> processes to use? For example, the following command tells me the
> regions of physical memory that are available to use:


ehhh what do you need it for???
without knowing that it's hard to give recommendations

[Jon M. Hanson] I'm writing a kernel module that dumps out the contents
of physical memory and the state of the CPU(s) based on an event. I
don't want to traverse memory that isn't actually used as system RAM
(like the 1 M hole, devices, etc.).
