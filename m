Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVEZXkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVEZXkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVEZXkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:40:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40874 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261849AbVEZXkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:40:32 -0400
Date: Thu, 26 May 2005 16:40:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: akpm@osdl.org, dino@in.ibm.com, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
Message-Id: <20050526164018.4880ecac.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
	<Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it make sense, Simon, to recommend to Andrew that
he take the simple patch I submitted yesterday for this
now, since it avoids a kernel crash and the risk of other
uglies?

Then, when we understand that improved scalability is needed,
and we have agreed on a solution to that, offer up a second
patch?

I don't mind doing fancier solutions if we need them, but
unless you sense we can obtain rapid agreement on something,
I don't think it's a good idea to avoid the simple fix, while
we are evaluating more complex solutions.

I for one do not have a sense of rapid agreement ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
