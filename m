Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWF3DCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWF3DCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 23:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWF3DCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 23:02:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9171 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964932AbWF3DCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 23:02:39 -0400
Date: Thu, 29 Jun 2006 20:02:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629200213.adf1f414.pj@sgi.com>
In-Reply-To: <44A4906A.5000509@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<20060629112642.66f35dd5.pj@sgi.com>
	<44A426DC.9090009@watson.ibm.com>
	<20060629124148.48d4c9ad.pj@sgi.com>
	<44A4492E.6090307@watson.ibm.com>
	<20060629152319.cfffe0d6.pj@sgi.com>
	<44A46C6C.1090405@watson.ibm.com>
	<20060629173805.f189de1a.pj@sgi.com>
	<20060629192129.f9d799ca.pj@sgi.com>
	<44A4906A.5000509@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh wrote:
> just pick some tasks and shut their data output out 

I missed this on first read.  Shutting down per-task (if it was a
property inherited on fork, and if it affectively eliminated the impact
on such tasks) would be equivalent to per CPU, for the configurations I
care about.

And you're right - per-task makes more sense than per-cpu.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
