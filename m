Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263210AbSJHV4O>; Tue, 8 Oct 2002 17:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263214AbSJHV4N>; Tue, 8 Oct 2002 17:56:13 -0400
Received: from thunk.org ([140.239.227.29]:61123 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S263210AbSJHVzq>;
	Tue, 8 Oct 2002 17:55:46 -0400
Date: Tue, 8 Oct 2002 18:01:15 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nathan Scott <nathans@sgi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] POSIX ACL configuration option
Message-ID: <20021008220115.GB9807@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Nathan Scott <nathans@sgi.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
References: <20021007025815.GD700@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007025815.GD700@frodo>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 12:58:15PM +1000, Nathan Scott wrote:
> Hi Linus,
> 
> This patch provides the configuration entry, help text and basic
> header file definitions for filesystems that support POSIX ACLs.
> The code implementing this in XFS is already merged in your tree,
> we're just missing these enabling pieces and that previous umask
> patch.

FWIW, I need this patch as well for as part of porting Andreas's ACL
code to 2.5.  So if it doesn't get accepted, I'll be resubmitting it
as part of the ext 2/3 ACL patch set...  

(the patch was developed and agreed upon between the XFS team and
Andreas Gruenbacher, so it's part of the ext 2/3 ACL patches.)

						- Ted
