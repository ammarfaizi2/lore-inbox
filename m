Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUFOAIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUFOAIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 20:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264657AbUFOAIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 20:08:01 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:21937 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264643AbUFOAHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 20:07:53 -0400
Date: Mon, 14 Jun 2004 17:06:05 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: ak@muc.de, anton@samba.org, linux-kernel@vger.kernel.org,
       lse-tech@projects.sourceforge.net
Subject: Re: NUMA API observations
Message-Id: <20040614170605.130d9a67.pj@sgi.com>
In-Reply-To: <20040614234430.GB90963@colin2.muc.de>
References: <20040614153638.GB25389@krispykreme>
	<20040614161749.GA62265@colin2.muc.de>
	<20040614142128.4da12a8d.pj@sgi.com>
	<20040614234430.GB90963@colin2.muc.de>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> I add some code to go upto a page now.

good.

> This adds a hardcoded limit of 32768 CPUs to libnuma. 

Ok - SGI has no issues with a 32768 CPU limit ... for now ;).

> I really dislike this error code [EINVAL] btw ...

Then use others ??

The way I learned Unix, decades ago, the tradition was to use a variety
of errno values, even if they were a slightly strange fit, in order to
provide more detailed error feedback.  Look for example at the rename(2)
or acct(2) system calls.

So long as the man page shows them, it can be helpful.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
