Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbWBII47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWBII47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWBII47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:56:59 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50054 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965209AbWBII47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:56:59 -0500
Date: Thu, 9 Feb 2006 00:55:53 -0800
From: Paul Jackson <pj@sgi.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: akpm@osdl.org, heiko.carstens@de.ibm.com, wli@holomorphy.com, ak@muc.de,
       mingo@elte.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       riel@redhat.com, dada1@cosmobay.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060209005553.088a2a78.pj@sgi.com>
In-Reply-To: <200602090335_MC3-1-B7FA-621E@compuserve.com>
References: <200602090335_MC3-1-B7FA-621E@compuserve.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck wrote:
> I don't think that's, um, "possible."  Even if you could discover how many
> empty sockets there were in a system, someone might be able to hotplug
> a board with more of them on it. 

That's going to depend on your system hardware configuration.

cpu_possible_map should be whatever is the largest set of
cpus you might possibly want to deal with plugging in.

Some hardware configurations will support more addition
of hardware cpus than others.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
