Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269653AbUJMIEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269653AbUJMIEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 04:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269648AbUJMIEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 04:04:39 -0400
Received: from palrel10.hp.com ([156.153.255.245]:15267 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S269643AbUJMIEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 04:04:12 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16748.57721.66330.638048@napali.hpl.hp.com>
Date: Wed, 13 Oct 2004 01:04:09 -0700
To: <akepner@sgi.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <akpm@osdl.org>, <jbarnes@sgi.com>
Subject: Re: bug in 2.6.9-rc4-mm1 ia64/mm/init.c 
In-Reply-To: <Pine.LNX.4.33.0410121705510.31839-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0410121705510.31839-100000@localhost.localdomain>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 12 Oct 2004 17:21:41 -0700 (PDT), <akepner@sgi.com> said:

  >> Hi Folks;

  >> Tried a kernel built with akpm's 2.6.9-rc4-mm1 patch today (using
  >> a default sn2 .config file.) It crashes on boot with:

  >> ....  SGI SAL version 3.40 Virtual mem_map starts at
  >> 0xa0007ffe85938000 Unable to handle kernel paging request at
  >> virtual address a0007ffeaf970000 swapper[0]: Oops 8813272891392
  >> [1] Modules linked in:

  >> I traced this down to a recent patch (see
  >> http://marc.theaimsgroup.com/?l=linux-mm&m=109723728329408&w=2)
  >> which contains:

Why was this patch even accepted?  It seemed rather dubious to me and
I don't recall much discussion on its merits or safety.

	--david
