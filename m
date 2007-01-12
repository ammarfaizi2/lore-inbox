Return-Path: <linux-kernel-owner+w=401wt.eu-S1161164AbXALX3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbXALX3L (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 18:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbXALX3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 18:29:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42928 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161164AbXALX3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 18:29:09 -0500
Date: Fri, 12 Jan 2007 15:29:04 -0800
From: Paul Jackson <pj@sgi.com>
To: "Sunil Naidu" <akula2.shark@gmail.com>
Cc: lsorense@csclub.uwaterloo.ca, linux-kernel@vger.kernel.org
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
Message-Id: <20070112152904.86c7e167.pj@sgi.com>
In-Reply-To: <8355959a0701121521h47acde7cy5f4661bb283ae782@mail.gmail.com>
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com>
	<20070112150349.GI17269@csclub.uwaterloo.ca>
	<8355959a0701121521h47acde7cy5f4661bb283ae782@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trying to understand, should I set CPUSETS=y

You don't need CPUSETS for this small a system.

But setting it is harmless - for example at least
one major commercial distribution enables CPUSETS
on almost all their product, most of which is running
on PC's less powerful than yours.

CPUSETS provides a facility for managing the memory
and processor placement of jobs running on what are
typically big NUMA systems.  Job X runs on CPUs 0-3
with memory on Nodes 0-1, while Job Y runs on CPUs
4-7 and Nodes 2-3.  And bigger ... to hundreds and
thousands of CPUs and Nodes.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
