Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbUJYMlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUJYMlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbUJYMlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:41:44 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:29901 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261777AbUJYMle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:41:34 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 25 Oct 2004 14:26:28 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] UML: kraxel's mconsole_proc rewrite
Message-ID: <20041025122628.GA8301@bytesex>
References: <20041020023558.GD8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020023558.GD8597@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 07:35:58PM -0700, Chris Wedgwood wrote:
> This is an update/resync of kraxel's mconsole_proc rewrite from about
> two months ago and IMO it should be merged as-is.

Jeff didn't like it because the original version also worked without
/proc being mounted.  Well, tree times, then it crashed.  I don't have
that in-deep knowledge of vfs stuff, but I somehow feel that the attempt
to access /proc without mounting it is the reason for the crash.  I
don't feel like bypassing the vfs layer so I didn't attempt to make it
wotk like the original version.

> I didn't originally write this, so no Signed-off-by...  I'd love to
> see his re-post with that though.

http://www.suse.de/~kraxel/uml/patches/2.6.9/ has my current patchset
with some (short) comments what the patches do.  The mconsole fix is
there as well, and will be there until either someone comes up with some
better fix (or it gets merged ;)

  Gerd

