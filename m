Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUJYC0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUJYC0w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 22:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUJYC0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 22:26:52 -0400
Received: from nevyn.them.org ([66.93.172.17]:7040 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261661AbUJYC0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 22:26:51 -0400
Date: Sun, 24 Oct 2004 22:26:48 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: Unwind information fix for the vsyscall DSO
Message-ID: <20041025022647.GA2015@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Roland McGrath <roland@redhat.com>
References: <20041024230138.GA22543@nevyn.them.org> <Pine.LNX.4.58.0410241626400.3016@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410241626400.3016@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 04:27:13PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 24 Oct 2004, Daniel Jacobowitz wrote:
> >
> > When working on GDB support I found a typo.  I assume the comment is
> > correct.  If you step to this particular instruction and backtrace, GDB gets
> > lost.
> > 
> > I haven't tested the fixed version yet, but I'm pretty confident in this
> > patch :-)  Please apply.
> 
> The patch looks obvious, but I'd still like to see a "yeah, I tested it 
> now, and yes, gdb DTRT after the fix.."

It looks good, but it triggered a related bug in GDB and 2.6.10-rc1
locked up while I was debugging that.  I'll get back to you once I can
test it.

-- 
Daniel Jacobowitz
