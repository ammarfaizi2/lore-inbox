Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVCOTNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVCOTNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVCOTEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:04:48 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:7161 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261788AbVCOTDn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:03:43 -0500
From: "Sven-Thorsten Dietrich" <sdietrich@mvista.com>
To: <linux-kernel@vger.kernel.org>
Cc: <cgl_discussion@lists.osdl.org>, <dcl_discussion@lists.osdl.org>
Subject: [ANNOUNCE] Robust Mutex Special Interest Group
Date: Tue, 15 Mar 2005 11:03:26 -0800
Message-ID: <1110849187.7364.10.camel@sdietrich-xp.vilm.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-MS-TNEF-Correlator: 0000000069FB83FCEB70AA41BD58898CFF8642FF440D6E00
X-OlkEid: FF440D6ED3247CEF4B3C204A833DD965C0336C9C
X-Evolution-Account: sdietrich@mvista.com
X-Evolution-Format: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Announcing the OSDL Robust Mutex Special Interest Group

 http://developer.osdl.org/dev/mutexes/


PURPOSE

The general mission of the mutexes SIG is to establish a forum centralizing discussion pertaining to mutex-specific planning and
development in Linux.  

The mutexes SIG is needed to promote forward-looking discussion between developers, users and maintainers. 

The mutexes SIG can reduce redundant development efforts, and could provision a base for exploring successful integration of
mutex-related technology into the Linux kernel.


BACKGROUND

Mutex implementations, like the applications that use them are plentiful. Mutex implementations are found in Linux libraries, in
Linux patches, as well as the Linux Kernel. 

For each mutex implementation, functionality is specialized. Almost all multi-threaded applications depend on mutexes. College
textbooks cite examples that work on Linux, but use mutex libraries dating back to older operating systems. 

Amazing applications, some as mobile as autonomous Robots, run Linux, but many of them augment the Linux kernel with mutex
enhancements that comply with given design criteria.

Advanced mutex functionality is minimal in the Linux kernel. With the advent of the real-time preemption concept, the mutex
conundrum does not relent. 

The real-time enhancements exist only as a kernel patch, as do many of the mutex implementations. But the real-time mutex
implementation is not compatible with any other advanced mutex implementation. 
 

INITIAL OBJECTIVES

The mutexes SIG will initially research the integration of two partially overlapped mutex implementations:

	1. http://people.redhat.com/~mingo/realtime-preempt/ 
	2. http://developer.osdl.org/dev/robustmutexes/
	

The realtime-preempt mutex in Ingo Molnar's patch implements a generic (portable) priority-inheriting kernel mutex with deadlock
detection support.

The Robust Mutex project (aka "Fusyn") also provides a generic (portable) priority-inheriting kernel / userspace mutex with deadlock
detection.

Both projects have specific, but also complementary, and overlapping objectives. Both projects implement several possibly common
subsystems, but the implementations are  functionally conflicting. Binary compatibility concerns emerge. 

It is conceivable that system-designers using Linux for advanced applications may wish to utilize the Robust (User-space) Mutex
patches at the same time as the real-time kernel enhancements. It is inefficient at best, to have two independent PI mechanisms
operating in the kernel. If RT and Fusyn are to coexist (they are birds of a feather 
after all), at least the priority inhertance functionality, as well as bounded list operations would need to be reconciled between
the two implementations.

Please refer to the OSDL site:

 http://developer.osdl.org/dev/mutexes/

for more information.

First conference call is Wed (3/16) at 9AM (pacific)

Thank You 

Sven



***********************************
Sven-Thorsten Dietrich
Real-Time Software Architect
MontaVista Software, Inc.
1237 East Arques Ave.
Sunnyvale, CA 94085

Phone: 408.992.4515
Fax: 408.328.9204
Email: sdietrich@mvista.com

http://www.mvista.com
Platform To Innovate
*********************************** 

