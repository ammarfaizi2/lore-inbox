Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTDFPgd (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTDFPgd (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:36:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25742
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263019AbTDFPgc (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:36:32 -0400
Subject: Re: objrmap and vmtruncate
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, andrea@suse.de, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <72740000.1049599406@[10.10.2.4]>
References: <20030404163154.77f19d9e.akpm@digeo.com>
	 <12880000.1049508832@flay><20030405024414.GP16293@dualathlon.random>
	 <20030404192401.03292293.akpm@digeo.com>
	 <20030405040614.66511e1e.akpm@digeo.com>  <72740000.1049599406@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049640548.962.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 15:49:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 03:23, Martin J. Bligh wrote:
> > 	14.91s user 75.30s system 24% cpu 6:15.84 total
> 
> Isn't the intent to use sys_remap_file_pages for these sort of workloads
> anyway? In which case partial objrmap = rmap for these tests, so we're
> still OK?

What matters is the worst case not the best case. Users will do non
optimal things on a regular basis. 

