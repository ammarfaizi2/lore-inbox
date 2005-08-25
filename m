Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVHYFsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVHYFsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVHYFsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:48:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:57304 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964849AbVHYFsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:48:30 -0400
Date: Wed, 24 Aug 2005 22:48:25 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cpu_exclusive sched domains fix broke ppc64
Message-Id: <20050824224825.2738ca2f.pj@sgi.com>
In-Reply-To: <17165.22994.174870.856032@cargo.ozlabs.ibm.com>
References: <17164.11361.437380.179789@cargo.ozlabs.ibm.com>
	<20050824223209.352a5f87.pj@sgi.com>
	<17165.22994.174870.856032@cargo.ozlabs.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you have CONFIG_NUMA=y ?

No I didn't.  That was it.  Now I too can
break the build.  Cool - thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
