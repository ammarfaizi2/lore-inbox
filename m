Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWF3AQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWF3AQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWF3AQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:16:06 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:13366 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751319AbWF3AQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:16:04 -0400
Message-ID: <44A46D3B.6060703@watson.ibm.com>
Date: Thu, 29 Jun 2006 20:15:55 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	<20060629094408.360ac157.pj@sgi.com>	<20060629110107.2e56310b.akpm@osdl.org>	<20060629112642.66f35dd5.pj@sgi.com>	<44A426DC.9090009@watson.ibm.com>	<20060629124148.48d4c9ad.pj@sgi.com>	<44A4492E.6090307@watson.ibm.com> <20060629152319.cfffe0d6.pj@sgi.com>
In-Reply-To: <20060629152319.cfffe0d6.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

>
>If the collectors are grouped along natural job boundaries, there might
>not be any need to combine multiple streams, hence no need for the
>timestamps you mention. 
>
Nope...as long as there are users who are using cpusets ONLY as a means 
of reducing sockets
to listen to, timestamps will be needed. Userspace can of course, choose 
to combine or not.



