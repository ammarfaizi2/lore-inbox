Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936855AbWLDNqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936855AbWLDNqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 08:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936856AbWLDNqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 08:46:47 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:44983 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S936855AbWLDNqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 08:46:47 -0500
Date: Mon, 4 Dec 2006 13:46:40 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD oddities with VIA PATA
Message-ID: <20061204134640.GA18837@deepthought.linux.bogus>
References: <20061201220134.GA22909@deepthought.linux.bogus> <20061201224240.GB22909@deepthought.linux.bogus> <el0a7s$soj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <el0a7s$soj$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 09:03:53PM -0800, Joshua Kwan wrote:
> On 12/01/2006 02:42 PM, Ken Moffat wrote:
> > On Fri, Dec 01, 2006 at 10:01:34PM +0000, Ken Moffat wrote:
> >> (i.) cdparanoia (9.8) works for root, but for a user it complains
> >> that the ioctl isn't cooked and refuses to run.  For test purposes,
> >> it runs ok for a user as suid root, but I imagine that increases
> >> the likelihood of unspeakable things happening.  (Fortunately, I
> >> don't have a dachshund)
> 
> For the record,
> cdparanoia III release 10pre0 (August 29, 2006)
> 
> works for me. My particular IDE adapter is:
> 
> 00:0f.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> (prog-if 8a [Master SecP PriP])
> 
> I have not tried older versions (yet). Could you try this and see if
> things are still broken?
> 
> -- 
> Joshua Kwan
> 
 I had tried it, but it turns out my trial used the old installed
libcdda_* libraries.  Now that I've got it using the new versions of
these, it looks as if 10pre0, with the debian patches, works ok for a
normal user (on x86_64 it needs the patch to be able to configure).

 Thanks for the pointer.  FWIW I can no longer replicate the failure
to mount a CD it had burned, will be doing more tests later.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
