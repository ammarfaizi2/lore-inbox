Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVDFEtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVDFEtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 00:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVDFEtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 00:49:12 -0400
Received: from palrel11.hp.com ([156.153.255.246]:31113 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262044AbVDFEtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 00:49:07 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16979.27158.381388.691910@napali.hpl.hp.com>
Date: Tue, 5 Apr 2005 21:48:22 -0700
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: davidm@hpl.hp.com, Andi Kleen <ak@muc.de>,
       Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <Pine.LNX.4.58.0504051729080.12307@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
	<200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
	<200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
	<20050318192808.GB38053@muc.de>
	<16963.2075.713737.485070@napali.hpl.hp.com>
	<Pine.LNX.4.58.0504051706110.12179@schroedinger.engr.sgi.com>
	<16979.11287.36091.610287@napali.hpl.hp.com>
	<Pine.LNX.4.58.0504051729080.12307@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 5 Apr 2005 17:33:59 -0700 (PDT), Christoph Lameter <clameter@engr.sgi.com> said:

  Christoph> Which benchmark would you recommend for this?

I don't know about "recommend", but I think SPECweb, SPECjbb,
the-UNIX-multi-user-benchmark-whose-name-I-keep-forgetting, and in
general anything that involves process-activity and/or large working
sets might be interesting (in other words: anything but
microbenchmarks; I'm afraid).

	--david
