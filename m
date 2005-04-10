Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVDJAkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDJAkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 20:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDJAkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 20:40:24 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11436 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261202AbVDJAkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 20:40:20 -0400
Date: Sat, 9 Apr 2005 17:39:44 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       mingo@elte.hu, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050409173944.247252eb.pj@engr.sgi.com>
In-Reply-To: <200504092321.j39NLk003976@blake.inputplus.co.uk>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<200504092321.j39NLk003976@blake.inputplus.co.uk>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph wrote:
> Watch out for when xargs invokes do_something more than once and the `<'
> is parsed by a different one than the `>'.

It will take a pretty long list to do that.  It seems that
GNU xargs on top of a Linux kernel has a 128 KByte ARG_MAX.

In the old days, with 4 KByte ARG_MAX limits, this would have
bitten us pretty quickly.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
