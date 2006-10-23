Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWJWQBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWJWQBu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWJWQBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:01:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39905 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751134AbWJWQBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:01:49 -0400
Date: Mon, 23 Oct 2006 09:01:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mbligh@google.com,
       nickpiggin@yahoo.com.au, akpm@osdl.org, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
In-Reply-To: <20061022225456.6adfd0be.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0610230900590.27654@schroedinger.engr.sgi.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
 <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com>
 <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com>
 <20061022035135.2c450147.pj@sgi.com> <20061022222652.B2526@unix-os.sc.intel.com>
 <20061022225456.6adfd0be.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006, Paul Jackson wrote:

> I believe that Christoph is actively working that problem.  Adding him
> to the cc list, so he can explain the state of this work more
> accurately.

That issue was fixed by retrying load balancing without the cpu that has 
all processes pinned.

