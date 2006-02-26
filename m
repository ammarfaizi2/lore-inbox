Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWBZWOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWBZWOG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWBZWOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:14:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:13233 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751162AbWBZWOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:14:04 -0500
Date: Sun, 26 Feb 2006 22:14:01 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Nix <nix@esperi.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Message-ID: <20060226221401.GS27946@ftp.linux.org.uk>
References: <200602261721.17373.jesper.juhl@gmail.com> <1140986578.24141.141.camel@mindpipe> <87wtfh3i9z.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wtfh3i9z.fsf@hades.wkstn.nix>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 09:46:32PM +0000, Nix wrote:
> On 26 Feb 2006, Lee Revell announced authoritatively:
> > What GCC version?  4.x still has the bug where it spews false warnings
> > about things being used uninitialized.
> 
> `4.x still has the bug where it cannot solve the Halting Problem'?
> 
> (i.e., there's a reason that warning uses the word *might*.)

The bug is in spewing tons of false positives, reducing S/N on that
warning to nearly useless level.  Note that in this case actually
missing some would be more useful if what remains is less diluted
by crap.
