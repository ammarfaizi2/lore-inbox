Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWAQQgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWAQQgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWAQQgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:36:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:19435 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932165AbWAQQgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:36:23 -0500
Date: Tue, 17 Jan 2006 17:36:22 +0100
From: Nick Piggin <npiggin@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: unmount oops in log_do_checkpoint
Message-ID: <20060117163622.GA20740@wotan.suse.de>
References: <20060116160420.GA21064@wotan.suse.de> <20060116212250.GD12159@atrey.karlin.mff.cuni.cz> <20060117113727.GB24083@wotan.suse.de> <20060117034601.6556322a.akpm@osdl.org> <20060117115945.GC24083@wotan.suse.de> <20060117140929.GA23497@wotan.suse.de> <20060117163235.GA18895@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117163235.GA18895@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 05:32:35PM +0100, Jan Kara wrote:
> > On Tue, Jan 17, 2006 at 12:59:45PM +0100, Nick Piggin wrote:
> > 
> > Maybe it is because people haven't been turning on their debugging options,
> > tsk tsk ;) It only oopses when DEBUG_SLAB and DEBUG_PAGEALLOC are both
> > enabled. And only then when the jbd patch is not reverted. Weird.
>   Hmm, that's really strange, maybe we have some use-after-free
> problem or so... I'll see what I can do :).
> 

Are you able to reproduce? If not I can test patches...

Nick
