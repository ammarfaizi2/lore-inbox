Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWATQgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWATQgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWATQgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:36:50 -0500
Received: from free.wgops.com ([69.51.116.66]:63500 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751072AbWATQgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:36:49 -0500
Date: Fri, 20 Jan 2006 09:36:35 -0700
From: Michael Loftis <mloftis@wgops.com>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <43D10FF8.8090805@superbug.co.uk>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <43D10FF8.8090805@superbug.co.uk>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 4:29:44 PM +0000 James Courtier-Dutton 
<James@superbug.co.uk> wrote:

> It is unclear what you are really ranting about here. The "stable" kernel
> is stable or at least as stable as it is going to be. It is left to
> distros to make it even more stable. The interface to user land has not
> changed.
> If all you are ranting about is the move from devfs to udevd, then all
> the user land tools dealing with them have been updated already.

That's the nail on the head exactly.  Why is this being done in an even 
numbered kernel?  This represents an API change that has knock on well 
outside of the kernel, and should be done in development releases.  Why is 
it LK is the only major project (that I know of) that does this?  This is 
akin to apache changing the format of httpd.conf and saying in say 1.3.38 
and saying 'well we made the userland tools too.'

>
> What is the real specific problem you are having?

Well there's a whole grab bag of them that I'll be getting to over the next 
few months, but the most immediate is the fact that I've gotten new 
hardware from a venduh that requires me to build a new Debian installer and 
new debian kernels.  I also have custom packages that depend on devfs being 
there and now it's not.

Yes I realise this change isn't out of the blue or anything, but it's in a 
'stable' kernel.  Why bother calling 2.6 stable?  We may as well have 
stayed at 2.5 if this sort of thing is going to continue to be pulled.

>
> James
>
>



--
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
