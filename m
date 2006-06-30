Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWF3UUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWF3UUB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWF3UUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:20:01 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:52205 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S1751125AbWF3UT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:19:59 -0400
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
       csturtiv@sgi.com, balbir@in.ibm.com, jlan@engr.sgi.com,
       Valdis.Kletnieks@vt.edu, Paul Jackson <pj@sgi.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <44A5770F.3080206@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	 <4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>
	 <44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>
	 <4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>
	 <20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>
	 <20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>
	 <20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>
	 <44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>
	 <44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>
	 <44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>
	 <44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>
	 <44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>
	 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	 <20060629094408.360ac157.pj@sgi.com>
	 <20060629110107.2e56310b.akpm@osdl.org> <44A57310.3010208@watson.ibm.com>
	 <44A5770F.3080206@watson.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Fri, 30 Jun 2006 16:19:55 -0400
Message-Id: <1151698795.5270.247.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-30-06 at 15:10 -0400, Shailabh Nagar wrote:

> 
> Also to get feedback on this kind of usage of the nl_pid field, the
> approach etc.
> 

It does not look unreasonable. I think you may have issues when you have
multiple such sockets opened within a single process. But 
do some testing and see how it goes.

cheers,
jamal

