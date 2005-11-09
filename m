Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVKIPA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVKIPA6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVKIPA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:00:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47563 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751240AbVKIPA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:00:58 -0500
Date: Wed, 9 Nov 2005 15:00:57 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/39] NLKD - early pseudo-fs
Message-ID: <20051109150057.GX7992@ftp.linux.org.uk>
References: <43720F5E.76F0.0078.0@novell.com> <43720F95.76F0.0078.0@novell.com> <43720FBA.76F0.0078.0@novell.com> <43720FF6.76F0.0078.0@novell.com> <43721024.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com> <43721119.76F0.0078.0@novell.com> <43721142.76F0.0078.0@novell.com> <20051109142926.GU7992@ftp.linux.org.uk> <4372179E.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4372179E.76F0.0078.0@novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 03:37:02PM +0100, Jan Beulich wrote:
> >What the hell for?  We _already_ have a way to get any set of files
> in
> >a filesystem as soon as we have VFS caches set up (and until then you
> >can't open anything anyway).
> 
> That's the whole point - a debugger wants this *before* VFS is set up
> (and thus obviously without going through VFS in the first place). One
> may argue that the naming is odd, but that's nothing I really care
> about.
> 
> >NAK.
> 
> Then suggest an alternative solution.

"Reduce the parts of your config needed that early on to something
saner in size"
