Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbULGQBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbULGQBG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 11:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbULGQBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 11:01:06 -0500
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:28024 "EHLO
	exil1.paradigmgeo.net") by vger.kernel.org with ESMTP
	id S261847AbULGQBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 11:01:05 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Correctly determine amount of "free memory"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 7 Dec 2004 17:58:01 +0200
Message-ID: <06EF4EE36118C94BB3331391E2CDAAD9D49AD3@exil1.paradigmgeo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Correctly determine amount of "free memory"
Thread-Index: AcTbwYo5j+S6lmIiSNepe8j1ElzJ2gAALSyAACyXxKA=
From: "Gregory Giguashvili" <Gregoryg@ParadigmGeo.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Experimenting with my simple memory allocation program for little more
time, I found that Free=MemTotal-Active gives kind of rough
approximation to the "free" memory amount. Can I make it somehow better?

What about SwapCached or Inact_target? Are there any pointers to the
information I might find useful on this subject other than
http://www.redhat.com/advice/tips/meminfo.html?

Thanks 
Giga
P.S. I need this to work with 2.4.19+ and 2.6 kernels...
