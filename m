Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbUJ0Uhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbUJ0Uhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbUJ0UdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:33:21 -0400
Received: from waste.org ([209.173.204.2]:1706 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262675AbUJ0U3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:29:52 -0400
Date: Wed, 27 Oct 2004 15:29:42 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll_setup questions
Message-ID: <20041027202942.GR31237@waste.org>
References: <16767.50093.59665.83462@segfault.boston.redhat.com> <20041027173031.GO31237@waste.org> <16767.61372.910664.763968@segfault.boston.redhat.com> <20041027194113.GP31237@waste.org> <16767.64161.361255.512272@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16767.64161.361255.512272@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 03:44:33PM -0400, Jeff Moyer wrote:
> mpm> Again, does the oops actually happen? I'd expect I'd have seen it by
> mpm> now if this were really a problem, but I don't mind adding another
> mpm> check.
> 
> I'm sorry, I should have said this before.  Yes, it occurs.  You simply
> need to have an interface in the down state, plugged into a network that
> will not auto-assign an address.  Then, modprobe netconsole, and don't
> specify what the local IP address is.  Believe it or not, I have a bug
> filed on this.  ;)

Ok, fair enough. Resend your patch when you've tested it and I'll
forward it on to Andrew.

-- 
Mathematics is the supreme nostalgia of our time.
