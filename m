Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbULFQDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbULFQDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbULFQDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:03:09 -0500
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:1965 "EHLO
	exil1.paradigmgeo.net") by vger.kernel.org with ESMTP
	id S261549AbULFQAM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:00:12 -0500
Content-class: urn:content-classes:message
Subject: RE: Correctly determine amount of "free memory"
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 6 Dec 2004 17:57:09 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <06EF4EE36118C94BB3331391E2CDAAD9CD067A@exil1.paradigmgeo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Correctly determine amount of "free memory"
Thread-Index: AcTbpogqhc+slmsYTWuju9VauF4XbAAAbmQg
From: "Gregory Giguashvili" <Gregoryg@ParadigmGeo.com>
To: "bert hubert" <ahu@ds9a.nl>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the side, it would not hurt to study 'overcommit' and mlock(2). The
answer to your question is > not static unless care is taken. 
I'm using mlock(2), but the problem is that I need to allocate as much
memory as possible without causing swapping, so I need to have _rough_
estimate before actually allocating the memory.

Thanks,
Giga
