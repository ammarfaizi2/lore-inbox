Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVHXVIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVHXVIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVHXVIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:08:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15025 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932224AbVHXVIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:08:10 -0400
Date: Wed, 24 Aug 2005 14:07:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cpu_exclusive sched domains on partial nodes temp fix
Message-Id: <20050824140755.4808d593.pj@sgi.com>
In-Reply-To: <20050824202133.GA10685@redhat.com>
References: <200508240401.j7O41qlB029277@hera.kernel.org>
	<20050824190651.GA10586@redhat.com>
	<20050824121340.3edf79d8.pj@sgi.com>
	<20050824202133.GA10685@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> It does build, but I'm unable to boot test it.

Ok - thanks.

Looks like Nick might be leaning toward the simpler path of disabling
this feature (defining dynamic sched domains using exclusive cpusets)
for 2.6.13, or some such.

We'll see.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
