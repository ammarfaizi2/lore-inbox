Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWCSCah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWCSCah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCSCah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:30:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38113 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751232AbWCSCah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:30:37 -0500
Date: Sat, 18 Mar 2006 18:30:33 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + cpumask-uninline-first_cpu.patch added to -mm tree
Message-Id: <20060318183033.e1eb46b4.pj@sgi.com>
In-Reply-To: <200603190214.k2J2EAUx022646@shell0.pdx.osdl.net>
References: <200603190214.k2J2EAUx022646@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoah - how come you are doing this by adding out of line cpumask
functions, instead of out of line bitmap functions, wrapped for both
cpumask and nodemask ?

There should be no need for a lib/cpumask.c file.

(I predict your response will be "show me the code" ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
