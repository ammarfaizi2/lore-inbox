Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUIKOK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUIKOK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 10:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268159AbUIKOK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 10:10:29 -0400
Received: from ozlabs.org ([203.10.76.45]:26347 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268158AbUIKOK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 10:10:26 -0400
Date: Sun, 12 Sep 2004 00:10:02 +1000
From: Anton Blanchard <anton@samba.org>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
Message-ID: <20040911141001.GD32755@krispykreme>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com> <20040911082834.10372.51697.75658@sam.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911082834.10372.51697.75658@sam.engr.sgi.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul,

> Initialize the top cpuset to only have the online
> CPUs and Nodes, rather than all possible.  This
> seems more natural to the observer.

How does this change interact with CPU hotplug?

Anton
