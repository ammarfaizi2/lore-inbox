Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVJZRZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVJZRZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 13:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbVJZRZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 13:25:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:28612 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964839AbVJZRZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 13:25:43 -0400
Date: Wed, 26 Oct 2005 10:25:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: magnus@valinux.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPUSETS: remove SMP dependency
Message-Id: <20051026102509.0b32006d.pj@sgi.com>
In-Reply-To: <20051026010922.5a8f70fe.akpm@osdl.org>
References: <20051026075345.21014.53533.sendpatchset@cherry.local>
	<20051026010922.5a8f70fe.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, responding to Magnus:
> > Remove the SMP dependency from CPUSETS.
> 
> Why?

As described in the posting that Magnus linked to, it seemed to me
like the cleaner approach - if there is no need to link two CONFIG
options, then don't.

Perhaps someone wants to build a uni-processor (UP) kernel for other
reasons, but still have it support running some stuff that depends
on cpusets being present.

But my vote on UP issues isn't worth much.  This patch is no biggie
to me either way.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
