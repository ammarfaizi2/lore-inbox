Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264318AbUEDUAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbUEDUAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUEDUAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:00:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13206 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264318AbUEDUAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:00:36 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, peter@mysql.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040504124800.67e1c819.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
	 <1083620245.23042.107.camel@abyss.local>
	 <20040503145922.5a7dee73.akpm@osdl.org> <4096DC89.5020300@yahoo.com.au>
	 <20040503171005.1e63a745.akpm@osdl.org> <4096E1A6.2010506@yahoo.com.au>
	 <1083631804.4544.16.camel@localhost.localdomain>
	 <20040503232928.1b13037c.akpm@osdl.org>
	 <1083683034.13688.7.camel@localhost.localdomain>
	 <1083699554.13688.64.camel@localhost.localdomain>
	 <20040504124800.67e1c819.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1083700735.13688.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2004 12:58:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-04 at 12:48, Andrew Morton wrote:
> Ram Pai <linuxram@us.ibm.com> wrote:
> >
> > I ran the following command:
> > 
> >  /root/sysbench-0.2.5/sysbench/sysbench --num-threads=256 --test=fileio
> >  --file-total-size=2800M --file-test-mode=rndrw run 
> > 
> 
> Alexey and I have been using 16 threads.
> 
> You don't tell us how much memory your lab machine has.  

It has 8GB but only 4Gb is being used. I will try with 256MB and 16
threads.

RP



