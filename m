Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVKGOl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVKGOl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVKGOl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:41:56 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:7070 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750726AbVKGOlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:41:55 -0500
Date: Mon, 7 Nov 2005 06:41:41 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ak@suse.de, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051107064141.7be80c49.pj@sgi.com>
In-Reply-To: <436F29BF.3010804@yahoo.com.au>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<20051106124944.0b2ccca1.pj@sgi.com>
	<436EC2AF.4020202@yahoo.com.au>
	<200511070442.58876.ak@suse.de>
	<20051106203717.58c3eed0.pj@sgi.com>
	<436EEF43.2050403@yahoo.com.au>
	<20051107014659.14c2631b.pj@sgi.com>
	<436F29BF.3010804@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok ... so a spinlock (task_lock) costs one barrier and one atomic more
than an rcu_read_lock (on a preempt kernel where both spinlock and
rcu_read_lock cost a preempt), or something like that.

Thanks, Nick.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
