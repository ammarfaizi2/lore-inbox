Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUHHKZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUHHKZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 06:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUHHKZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 06:25:11 -0400
Received: from darwin.snarc.org ([81.56.210.228]:8651 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S264984AbUHHKZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 06:25:06 -0400
Date: Sun, 8 Aug 2004 12:25:12 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESENT] remove hardcoded offsets from ppc asm
Message-ID: <20040808102512.GA13798@snarc.org>
References: <20040807151838.GA6760@snarc.org> <1091921531.14102.2.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091921531.14102.2.camel@gaston>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040803i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 09:32:12AM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2004-08-08 at 01:18, Vincent Hanquez wrote:
> > 	Hi LKML,
> > 
> > This patch removes hardcoded offsets from ppc asm.
> > It generate offsets for thread_info structure instead of hardcoding them.
> > 
> > Please apply or comments,
> > 
> > Signed-off-by: Vincent Hanquez <tab@snarc.org>
> 
> I have nothing against the idea, but why the hell did you change the
> constant names, turning them partially to lowercase ? They are just
> fine beeing uppercase, this is more consistent, and that would
> reduce the size of your patch signficantly.

Hi Benjamin, it seems to be the 'convention'. I did the same comment
some time ago to Brian Gerst with his patch for i386.

http://marc.theaimsgroup.com/?l=linux-kernel&m=108454158825656&w=2

But if you prefer a smaller patch, without changing the constant
name, I can do that too.

Sorry about the first set of patch, I didn't see your reply. I just saw
it today on the archive.

-- 
Tab
