Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267905AbUHESnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267905AbUHESnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267874AbUHESmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:42:05 -0400
Received: from fmr05.intel.com ([134.134.136.6]:18387 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267921AbUHESkO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:40:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Date: Thu, 5 Aug 2004 11:39:21 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F93C6@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Thread-Index: AcR69fW9OH51cuPOS6KGCtJsw76iXAAJXeqw
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Ulrich Drepper" <drepper@redhat.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <robustmutexes@lists.osdl.org>, <rusty@rustcorp.com.au>,
       <jamie@shareable.org>
X-OriginalArrivalTime: 05 Aug 2004 18:39:26.0827 (UTC) FILETIME=[892233B0:01C47B1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ingo Molnar [mailto:mingo@elte.hu]
>
> and if fusyn.c is fast enough then we could even try to do normal
> futexes via fusyn.c - but not doing the registration/unregistration
> (hence losing the priority guarantee, but still sharing much of the
> codepath). This would be the most robust internal design i believe.

The priority guarantee or the robustness guarantee? I am guessing you
meant the second; the priority-based wakeup you will always get it.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
