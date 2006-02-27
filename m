Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWB0UQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWB0UQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWB0UQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:16:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61844 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932331AbWB0UQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:16:24 -0500
Date: Mon, 27 Feb 2006 12:16:05 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Message-Id: <20060227121605.fb41d505.pj@sgi.com>
In-Reply-To: <p731wxo1tpr.fsf@verdi.suse.de>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
	<p731wxo1tpr.fsf@verdi.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Is there a way to use it without cpumemsets? 

Not that I know of.  So far as I can recall, the task->mems_allowed
field (over which the spreading is done) is only manipulated by the
cpuset code.  So at least what I have here requires cpusets to have
any useful affect, yes.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
