Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVDFAgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVDFAgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVDFAgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:36:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21638 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262041AbVDFAgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:36:51 -0400
Date: Tue, 5 Apr 2005 17:33:59 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: davidm@hpl.hp.com
cc: Andi Kleen <ak@muc.de>, Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <16979.11287.36091.610287@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0504051729080.12307@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
 <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
 <20050318192808.GB38053@muc.de> <16963.2075.713737.485070@napali.hpl.hp.com>
 <Pine.LNX.4.58.0504051706110.12179@schroedinger.engr.sgi.com>
 <16979.11287.36091.610287@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, David Mosberger wrote:

> What LMbench test other than fork/exec would you have expected to be
> affected by this?  LMbench is not a good benchmark for this (remember:
> it's a _micro_ benchmark).

LMbench does a variety of things and I expected to see at least
something on the page fault test and hopefully also some variations for
other tests.

Which benchmark would you recommend for this?

