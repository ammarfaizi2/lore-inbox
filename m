Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVKOQ7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVKOQ7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVKOQ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:59:05 -0500
Received: from fmr21.intel.com ([143.183.121.13]:23235 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S964945AbVKOQ7C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:59:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: + perfmon2-reserve-system-calls.patch added to -mm tree
Date: Tue, 15 Nov 2005 08:58:03 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04F63200@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: + perfmon2-reserve-system-calls.patch added to -mm tree
Thread-Index: AcXp/DNlo3k7aKzCTiaO8G9h+IAZTwAB9gTg
From: "Luck, Tony" <tony.luck@intel.com>
To: <eranian@hpl.hp.com>
Cc: "Andi Kleen" <ak@muc.de>, "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, "Arnd Bergmann" <arnd@arndb.de>,
       <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>,
       <paulus@samba.org>, <stephane.eranian@hp.com>
X-OriginalArrivalTime: 15 Nov 2005 16:58:04.0986 (UTC) FILETIME=[BEFC29A0:01C5EA05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It does look like I'm a bit behind with syscalls in the
32-bit emulation table.  Ones that may need to be added are:

274  sys_mbind
275  sys_get_mempolicy
276  sys_set_mempolicy
286  sys_add_key
287  sys_request_key
288  sys_keyctl
289  sys_ioprio_set
290  sys_ioprio_get
291  sys_inotify_init
292  sys_inotify_add_watch
293  sys_inotify_rm_watch

Plus a general whitespace cleanup (lots of lines start with
<space>+<tab>).

-Tony
