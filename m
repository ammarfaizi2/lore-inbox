Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbTBFRfo>; Thu, 6 Feb 2003 12:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbTBFRfn>; Thu, 6 Feb 2003 12:35:43 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:51723 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267377AbTBFRfn>; Thu, 6 Feb 2003 12:35:43 -0500
Date: Thu, 6 Feb 2003 17:45:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030206174520.A13827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Wagner <daw@mozart.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <200302061502.KAA06538@moss-shockers.ncsc.mil> <20030206151820.A11019@infradead.org> <b1u59n$lhl$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b1u59n$lhl$1@abraham.cs.berkeley.edu>; from daw@mozart.cs.berkeley.edu on Thu, Feb 06, 2003 at 05:16:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[it would be really nice if you at least Cc'ed me when replying to my mails..
  *sigh*]

On Thu, Feb 06, 2003 at 05:16:39PM +0000, David Wagner wrote:
> Christoph Hellwig  wrote:
> >Well, selinux is still far from a mergeable shape and even needed additional
> >patches to the LSM tree last time I checked.  This think of submitting hooks
> >for code that obviously isn't even intende to be merged in mainline is what
> >I really dislike, and it's the root for many problems with LSM.
> 
> You keep bringing up SELinux.  Maybe you dislike SELinux; I don't know.
> In any case, LSM is not there just to support SELinux.  It's intended
> to support a broad range of security modules and security policies.
> LSM is bigger than just SELinux.

I bring up selinux because it's the only module in the lsm patches that I
consider more than just a bunch of hacks.  So, no it's not a dislike but
they only thing I actually consider worth mentioning.

