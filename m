Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVCGIEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVCGIEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVCGIEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:04:30 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:55766 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261672AbVCGIET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:04:19 -0500
Date: Sun, 6 Mar 2005 23:50:27 -0800
From: Paul Jackson <pj@sgi.com>
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-Id: <20050306235027.268da803.pj@sgi.com>
In-Reply-To: <pan.2005.03.06.17.10.41.114607@voxel.net>
References: <20050304222146.GA1686@kroah.com>
	<20050305104305.GB7671@pclin040.win.tue.nl>
	<pan.2005.03.06.17.10.41.114607@voxel.net>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres wrote:
> An obvious fix is an obvious fix.

Perhaps in theory.  But in practice, any fix bears some risk.

They have nothing against "obvious" fixes.  But unless additional
criteria are also met, such fixes are for someone else to apply.

> >>  - It can not contain any "trivial" fixes in it (spelling changes,
> >>    whitespace cleanups, etc.)
> 
> This and the "it must fix a problem" are basically saying the same thing.

Not at all.  Let me put it this way.

If a change that fixes a problem is included in a patch with another
change that makes trivial changes (typo fix, say), the patch will
be rejected.

The statement:

    "It must fix a problem and it must _not_ contain anything else,
     such as 'trivial' fixes."

is _obviously_ not the same as:

    "It must fix a problem."

(Notice how quickly even the obvious becomes unobvious ...;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
