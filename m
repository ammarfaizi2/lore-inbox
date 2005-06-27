Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVF0TqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVF0TqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVF0ToX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:44:23 -0400
Received: from fmr23.intel.com ([143.183.121.15]:38588 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261458AbVF0Tnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:43:35 -0400
Message-Id: <200506271942.j5RJgig23410@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <christoph@lameter.com>
Cc: "'Badari Pulavarty'" <pbadari@us.ibm.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Lincoln Dale" <ltd@cisco.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: RE: [rfc] lockless pagecache
Date: Mon, 27 Jun 2005 12:42:44 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcV7TZtHaSHpyPSvRqmDYudh5n1MVAAAL69Q
In-Reply-To: <Pine.LNX.4.62.0506271221540.21616@graphe.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Monday, June 27, 2005 12:23 PM
> On Mon, 27 Jun 2005, Chen, Kenneth W wrote:
> > I don't recall seeing tree_lock to be a problem for DSS workload either.
> 
> I have seen the tree_lock being a problem a number of times with large 
> scale NUMA type workloads.

I totally agree!  My earlier posts are strictly referring to industry
standard db workloads (OLTP, DSS).  I'm not saying it's not a problem
for everyone :-)  Obviously you just outlined a few ....

- Ken

