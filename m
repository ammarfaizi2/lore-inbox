Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVIJQRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVIJQRm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 12:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVIJQRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 12:17:42 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:12860 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750832AbVIJQRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 12:17:42 -0400
Date: Sat, 10 Sep 2005 18:19:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050910161917.GA22113@mars.ravnborg.org>
References: <20050911012033.5632152f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911012033.5632152f.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 01:20:33AM +1000, Stephen Rothwell wrote:
> The latest Linus-git tree generates asm-offsets.h in the source tree even
> if you use O=... I don't know how to fix this, but it means that the
> source tree cannot be read only.
My bad. I checked it compiled, not where it saved the file.
I will have a fix tonight.

	Sam
