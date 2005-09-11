Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVIKWNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVIKWNO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVIKWNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:13:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750965AbVIKWNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:13:13 -0400
Date: Sun, 11 Sep 2005 15:12:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: petero2@telia.com, linux-kernel@vger.kernel.org
Subject: Re: What's up with the GIT archive on www.kernel.org?
Message-Id: <20050911151240.478006e0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com>
	<Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  On Sun, 11 Sep 2005, Peter Osterlund wrote:
>  >
>  > Since about 20 hours ago, it seems the
>  > linux/kernel/git/torvalds/linux-2.6.git/ archive on www.kernel.org
>  > alternates between at least two different HEAD commits.
> 
>  Are there perhaps two different front-end machines? And mirroring
>  problems?

I think so.  Yesterday I was wgetting files from Greg's directory on
kernel.org and kept on getting two totally different sets of files between
successive identical wget invokations.

> Does anyone else see this? "host www.kernel.org" gives me two IP
> addresses:
> 
>          www.kernel.org is an alias for zeus-pub.kernel.org.
>          zeus-pub.kernel.org has address 204.152.191.5
>          zeus-pub.kernel.org has address 204.152.191.37
> 
> Is it possible that one of those computers hasn't received the latest
> changes for some reason?

Yes, I'd say that's the problem.
