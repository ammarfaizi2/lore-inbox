Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWJPK5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWJPK5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWJPK5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:57:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40614 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751496AbWJPK5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:57:01 -0400
Date: Mon, 16 Oct 2006 03:56:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: akpm@osdl.org, neilb@suse.de, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 4] cpumask: add highest_possible_node_id
Message-Id: <20061016035644.1c99ad9b.pj@sgi.com>
In-Reply-To: <1154669719.21040.2351.camel@hole.melbourne.sgi.com>
References: <1154669719.21040.2351.camel@hole.melbourne.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (of August 3, 2006) added (after a bit of fixing) a nodemask
related routine to lib/cpumask.c.  Granted, there is no lib/nodemask.c,
and Andrew suggested lib/cpumask.c.

But at least it should have added

	#include <linux/nodemask.h>

to lib/cpumask.c, no?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
