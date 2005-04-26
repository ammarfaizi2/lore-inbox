Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVDZFkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVDZFkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVDZFkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:40:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65223 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261205AbVDZFkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:40:06 -0400
Date: Tue, 26 Apr 2005 06:40:17 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, pasky@ucw.cz, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Message-ID: <20050426054017.GS13052@parcelfarce.linux.theplanet.co.uk>
References: <426DCA75.901@pobox.com> <Pine.LNX.4.21.0504260103050.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504260103050.30848-100000@iabervon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, it still complains about commit-id
> 
> In this case, it would complain about .git/HEAD even if it found
> commit-id. The right solution is probably to suppress that part if there's
> no .git/HEAD.

The right thing is to stop assuming that everyone has . in their $PATH,
to start with...
