Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTDDVrJ (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbTDDVrJ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:47:09 -0500
Received: from to-telus.redhat.com ([207.219.125.105]:60156 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S261376AbTDDVrI (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 16:47:08 -0500
Date: Fri, 4 Apr 2003 16:58:37 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030404165837.A21390@redhat.com>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain> <20030404105417.3a8c22cc.akpm@digeo.com> <20030404214547.GB16293@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030404214547.GB16293@dualathlon.random>; from andrea@suse.de on Fri, Apr 04, 2003 at 11:45:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 11:45:47PM +0200, Andrea Arcangeli wrote:
> Maybe I'm missing something, I'm curious to hear what you think and what
> other cases needs this syscall even after 1) and 2) are fixed.

It's useful for UML and emulators that simulate page tables too.

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
