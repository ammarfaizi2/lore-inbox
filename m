Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbWJUXFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWJUXFu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 19:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWJUXFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 19:05:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27068 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161151AbWJUXFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 19:05:49 -0400
Date: Sat, 21 Oct 2006 16:05:17 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: dino@in.ibm.com, nickpiggin@yahoo.com.au, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061021160517.0e98dabe.pj@sgi.com>
In-Reply-To: <20061020161403.C8481@unix-os.sc.intel.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<4538F34A.7070703@yahoo.com.au>
	<20061020120005.61239317.pj@sgi.com>
	<20061020203016.GA26421@in.ibm.com>
	<20061020144153.b40b2cc9.pj@sgi.com>
	<20061020223553.GA14357@in.ibm.com>
	<20061020161403.C8481@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> And whenever a child cpuset sets this use_cpus_exclusive flag, remove
> those set of child cpuset cpus from parent cpuset and also from the ..

That reminds me a little of Dinakar's first patch to partition sched
domains based on the cpuset configuration:

  Subject: [Lse-tech] [RFC PATCH] Dynamic sched domains aka Isolated cpusets
  From: Dinakar Guniguntala <dino@in.ibm.com>
  Date: Tue, 19 Apr 2005 01:56:44 +0530
  http://lkml.org/lkml/2005/4/18/187

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
