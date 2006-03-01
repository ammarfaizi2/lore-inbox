Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWCAFhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWCAFhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 00:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWCAFhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 00:37:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932343AbWCAFhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 00:37:05 -0500
Date: Tue, 28 Feb 2006 21:35:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: ericvh@gmail.com (Eric Van Hensbergen)
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Subject: Re: [PATCH 0/3] v9fs: rework fid management
Message-Id: <20060228213554.395fc59f.akpm@osdl.org>
In-Reply-To: <20060227041139.A58695A8075@localhost.localdomain>
References: <20060227041139.A58695A8075@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ericvh@gmail.com (Eric Van Hensbergen) wrote:
>
> 
> This set of patches attempts to simplify the mapping of 9P fids to Linux VFS.
> The resulting simplification fixes several bugzilla bug-reports with no loss in
> functionality for current file systems.  Its a pretty major change, but it has
> passed all of our regressions, so its up to you guys whether or not you want to 
> accept this into 2.6.16 or wait for the 2.6.17 window to open up.  For what its 
> worth, systems seem to be more stable with it than without it.
> 

For things like recently-merged filesystems I'm inclined to fast-track
fixes regardless of what stage we're at.

(I''d have merged them today if these messages had landed in my inbox, but
for some reason they did not.  Another good reason for cc'ing the mailing
list.)
