Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUBRJtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 04:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUBRJtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 04:49:12 -0500
Received: from mail.shareable.org ([81.29.64.88]:26757 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263946AbUBRJtK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 04:49:10 -0500
Date: Wed, 18 Feb 2004 09:48:58 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Robert White <rwhite@casabyte.com>, "'Theodore Ts'o'" <tytso@mit.edu>,
       "'Pavel Machek'" <pavel@ucw.cz>, "'the grugq'" <grugq@hcunix.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040218094858.GA28599@mail.shareable.org>
References: <20040204062936.GA2663@thunk.org> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAiYFsPtMTN0OBYHMfkO9ONQEAAAAA@casabyte.com> <20040213034119.GK25499@mail.shareable.org> <4032E0A6.7060608@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4032E0A6.7060608@tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> But these are not mutually exclusive. Even if the data are encrypted, 
> when I delete something I want it GONE. That way even if a TLA with 
> resources to break the crypto steals my device, my previous password 
> list is safe.

Fair point.  Per-inode keys won't protect against a resourceful TLA
(if such a TLA ever exists).

-- Jamie
