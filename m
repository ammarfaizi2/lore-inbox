Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVDCTGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVDCTGT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 15:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVDCTGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 15:06:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42668 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261865AbVDCTGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 15:06:16 -0400
Subject: Re: AIM9 slowdowns between 2.6.11 and 2.6.12-rc1
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504031532570.25594@skynet>
References: <Pine.LNX.4.58.0504031532570.25594@skynet>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 12:06:10 -0700
Message-Id: <1112555170.7189.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 15:37 +0100, Mel Gorman wrote:
> While testing the page placement policy patches on 2.6.12-rc1, I noticed
> that aim9 is showing significant slowdowns on page allocation-related
> tests. An excerpt of the results is at the end of this mail but it shows
> that page_test is allocating 18000 less pages.
> 
> I did not check who has been recently changing the buddy allocator but
> they might want to run a benchmark or two to make sure this is not
> something specific to my setup.

Can you get some kernel profiles to see what, exactly, is causing the
decreased performance?  Also, what kind of system do you have?  Does
backing this out help?  If not, can you test some BK snapshots to see
when this started occurring?  

http://linus.bkbits.net:8080/linux-2.5/cset@422de02c1628MP_noKSum9sGlTaC-Q

-- Dave

