Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUHTXXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUHTXXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 19:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268793AbUHTXXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 19:23:34 -0400
Received: from ozlabs.org ([203.10.76.45]:4588 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268113AbUHTXXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 19:23:33 -0400
Date: Sat, 21 Aug 2004 09:20:50 +1000
From: Anton Blanchard <anton@samba.org>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.8.1-mm2 - reiser4
Message-ID: <20040820232050.GI1945@krispykreme>
References: <Pine.LNX.4.44.0408201753250.4192-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0408201852140.4192-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408201852140.4192-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh, and another one.  The reiser 4 system call
> sys_reiserfs seems to need an additional patch,
> which is craftily hidden inside reiser4-only.patch
> 
> That patch creates fs/reiser4/linux-5_reiser4_syscall.patch,
> which I can only assume reiser 4 users should apply...

I would assume a compat layer interface would be a requirement to
merging such a syscall interface. Does it exist?

Anton
