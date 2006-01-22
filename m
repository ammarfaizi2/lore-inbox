Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWAVVri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWAVVri (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWAVVri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:47:38 -0500
Received: from fmr13.intel.com ([192.55.52.67]:4015 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750862AbWAVVrh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:47:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: SMP+nosmp=hang [was: Re: 2.6.15-rc5-mm2]
Date: Sun, 22 Jan 2006 16:47:24 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005CA25F3@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMP+nosmp=hang [was: Re: 2.6.15-rc5-mm2]
Thread-Index: AcYe6j1Xk7DQvf1qSZeQye3YikTWMQAstYiw
From: "Brown, Len" <len.brown@intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>,
       "J.A. Magallon" <jamagallon@able.es>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Jan 2006 21:47:27.0482 (UTC) FILETIME=[6FEDCDA0:01C61F9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think nosmp has been broken for a long time:

http://bugzilla.kernel.org/show_bug.cgi?id=1641

try maxcpus=1 instead of nosmp.

-Len
