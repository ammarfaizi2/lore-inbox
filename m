Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282082AbRLLUtH>; Wed, 12 Dec 2001 15:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282092AbRLLUs6>; Wed, 12 Dec 2001 15:48:58 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:32263 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S282082AbRLLUsr>; Wed, 12 Dec 2001 15:48:47 -0500
Date: Wed, 12 Dec 2001 20:54:44 +0000
From: Matt <matt@bodgit-n-scarper.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] LVM and (I think) devfs
Message-ID: <20011212205444.A27950@mould.bodgit-n-scarper.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011212170921.A25596@mould.bodgit-n-scarper.com> <200112121726.fBCHQWu15088@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112121726.fBCHQWu15088@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 10:26:32AM -0700, Richard Gooch wrote:
> 
> Please try kernel 2.4.16 and see if the problem persists. There were
> devfs and minor LVM changes since then. Make sure you at least Cc: me.

Ah, a slight problem there. The LVM volume happens to reside on an AACRAID
controller, which won't get passed fsck'ing with 2.4.16. 2.4.17-pre8 seems
to have fixed that problem for reasons unknown.

The .17-preX LVM code should be based on, if not the same as the .16 code
shouldn't it? The log suggests only changes on the devfs side. If I just
stuck to the LVM code in the kernel, instead of using the code provided in
the LVM 1.0.1 package, would that be a fair test?

Cheers

Matt
-- 
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy"
