Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbVKCUAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbVKCUAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 15:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbVKCUAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 15:00:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29660 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030465AbVKCUAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 15:00:49 -0500
Date: Thu, 3 Nov 2005 12:00:13 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mbligh@mbligh.org, mel@csn.ul.ie, arjan@infradead.org,
       nickpiggin@yahoo.com.au, haveblue@us.ibm.com, mingo@elte.hu,
       akpm@osdl.org, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       arjanv@infradead.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051103120013.093b698f.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0511030955110.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>
	<Pine.LNX.4.58.0511010137020.29390@skynet>
	<4366D469.2010202@yahoo.com.au>
	<Pine.LNX.4.58.0511011014060.14884@skynet>
	<20051101135651.GA8502@elte.hu>
	<1130854224.14475.60.camel@localhost>
	<20051101142959.GA9272@elte.hu>
	<1130856555.14475.77.camel@localhost>
	<20051101150142.GA10636@elte.hu>
	<1130858580.14475.98.camel@localhost>
	<20051102084946.GA3930@elte.hu>
	<436880B8.1050207@yahoo.com.au>
	<1130923969.15627.11.camel@localhost>
	<43688B74.20002@yahoo.com.au>
	<255360000.1130943722@[10.10.2.4]>
	<4369824E.2020407@yahoo.com.au>
	<306020000.1131032193@[10.10.2.4]>
	<1131032422.2839.8.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
	<Pine.LNX.4.58.0511031613560.3571@skynet>
	<Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
	<309420000.1131036740@[10.10.2.4]>
	<Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
	<311050000.1131040276@[10.10.2.4]>
	<Pine.LNX.4.64.0511030955110.27915@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We simply DO NOT CARE about some theoretical "general case", because the 
> general case is (a) insane and (b) impossible to cater to without 
> excessive complexity.

The lawyers have a phrase for this:

	Hard cases make bad law.

For us, that's bad code.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
