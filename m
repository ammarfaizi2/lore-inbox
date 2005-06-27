Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVF0TLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVF0TLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVF0TLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:11:05 -0400
Received: from fmr21.intel.com ([143.183.121.13]:58318 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261619AbVF0TH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:07:58 -0400
Message-Id: <200506271905.j5RJ5ag22991@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Badari Pulavarty'" <pbadari@us.ibm.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, "Lincoln Dale" <ltd@cisco.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: RE: [rfc] lockless pagecache
Date: Mon, 27 Jun 2005 12:05:36 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcV7STUcsUHyaCVPRsq/iJiIYzQpNQAAa/nw
In-Reply-To: <1119898264.13376.89.camel@dyn9047017102.beaverton.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote on Monday, June 27, 2005 11:51 AM
> On Mon, 2005-06-27 at 11:14 -0700, Chen, Kenneth W wrote:
> > Typically shared memory is used as db buffer cache, and O_DIRECT is
> > performed on these buffer cache (hence O_DIRECT on the shared memory).
> > You must be thinking some other workload.  Nevertheless, for OLTP type
> > of db workload, tree_lock hasn't been a problem so far.
> 
> What about DSS ? I need to go back and verify some of the profiles
> we have.

I don't recall seeing tree_lock to be a problem for DSS workload either.

