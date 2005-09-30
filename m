Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbVI3OaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVI3OaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbVI3OaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:30:20 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:40900 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030323AbVI3OaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:30:19 -0400
Date: Fri, 30 Sep 2005 07:30:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset crapectomy
Message-Id: <20050930073008.67c9113c.pj@sgi.com>
In-Reply-To: <20050930022643.GA7992@ftp.linux.org.uk>
References: <20050930022643.GA7992@ftp.linux.org.uk>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Al, for picking up after us.

Actually, we can remove one more line of code.  The line right above
the code you ripped out is:

	*s = '\0';

I think this line is utterly useless.

Perhaps I can find time to prepare a trivial "cpuset crapectomy stage
two" patch to remove this line too.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
