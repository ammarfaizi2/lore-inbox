Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVFAHgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVFAHgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVFAHgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:36:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32229 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261316AbVFAHge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:36:34 -0400
Date: Wed, 1 Jun 2005 09:36:32 +0200
From: Jan Kara <jack@suse.cz>
To: Alexander Nyberg <alexn@telia.com>
Cc: sct@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Assertion failure in log_do_checkpoint() and the fix
Message-ID: <20050601073632.GC5933@atrey.karlin.mff.cuni.cz>
References: <1117483858.956.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117483858.956.15.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> This was brought up earlier at http://lkml.org/lkml/2005/5/6/30
> 
> Is there any reason for this one-liner to not go into mainline? It
> appears to fix up a quite nasty failure. Even if it is not the real
> correct long term solution it has to be better than having boxes
> panic'ing under certain loads?
  Actually I just wanted to write Andrew to include the two one-liners
that fix the real bugs (the patches will follow soon). I have the bigger
patch splitting the checkpoint lists but that is certainly not a 2.6.12
thing. And this bigger patch needs the two one-line fixes anyway.
I'll elaborate more in the mails with the patches...

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
