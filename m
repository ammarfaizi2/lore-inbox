Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUAFWSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUAFWSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:18:23 -0500
Received: from [66.35.79.110] ([66.35.79.110]:54415 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S264563AbUAFWSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:18:22 -0500
Date: Tue, 6 Jan 2004 14:17:01 -0800
From: Tim Hockin <thockin@hockin.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Message-ID: <20040106221701.GA7768@hockin.org>
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com> <20040106215018.GA911@sun.com> <3FFB316A.6000004@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFB316A.6000004@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the resend, forgot to CC the lists)

On Tue, Jan 06, 2004 at 02:06:34PM -0800, H. Peter Anvin wrote:
> > Can you maybe share some details?  I think this deign moves MORE state to
> > userspace (expiry aside).  The "state" in kernel is really mostly sent back
> > to userspace.  No more passing pipes into the kernel (state) or tracking the
> > pgid of the daemon (state).
> 
> If you want to fire up a new daemon, all that state that was supposed to
> be kept in userspace has to be reconstructed.  That means the kernel has
> to have all that information; this would include stuff like what kind of
> umount policy you want for each key entry (the current daemon doesn't do
> that because it doesn't have the proper state.)

I'm not really sure what you're saying., here.  I'm sorry.  Not trying to be
thick, just not understanding.

What umount policy?  What state is supposed to be kept in userspace that isn't?

> > The daemon as it stands does NOT handle namespaces, does NOT handle expiry
> > well, and is a pretty sad copy of an old design.
> 
> First of all, I'll be blunt: namespaces currently provide zero benefit
> in Linux, and virtually noone uses them.  I have discussed this with
> Linus in the past, and neither one of us see namespaces as being worth

Let's get rid of them, then.  Make life that much easier.
