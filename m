Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUBCJDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 04:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUBCJDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 04:03:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:7383 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265940AbUBCJDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 04:03:34 -0500
Date: Tue, 3 Feb 2004 01:04:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3-mm1
Message-Id: <20040203010456.3f3a2618.akpm@osdl.org>
In-Reply-To: <1075798370.1829.80.camel@tribesman.namesys.com>
References: <20040202235817.5c3feaf3.akpm@osdl.org>
	<1075798370.1829.80.camel@tribesman.namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev <vs@namesys.com> wrote:
>
>  What would we have to provide to get reiser4 included? Or, do you think
>  that it is not mature enough for inclusion?

I haven't looked at it.  Please send me the two patches (core kernel diff
and the fs) along with complete usage instructions so that people know
where to find the userspace tools, how to run them etc.  Also please ensure
that all mount options are documented and that any known bugs are
described.

Be aware that the barriers for a new filesystem are relatively high: each
one adds a significant maintenance burden to the VFS and MM developers.  It
will need cautious review.

But that doesn't mean we cannot get it out there, get you some more testing
and exposure.  
