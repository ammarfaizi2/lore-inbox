Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbUJWPAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUJWPAr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 11:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUJWO4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:56:34 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:61664 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261215AbUJWOzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:55:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VarUrYIDs0KA4uoLlitxZfsn0nW7HJyrtQOhDTSExAhfiogdfuli+iwMVQBDMZ309GR/21lkSgOTTJF6DeVgn23CS5QcXHmnnqyWqWrBJcPkqKAMTq7Lsrsz4t3eaKUpbe5aT4R/E5j9T3BfC+e+ybed7YIqNVDMyltxNeYek9s=
Message-ID: <9e473391041023075436f6983c@mail.gmail.com>
Date: Sat, 23 Oct 2004 10:54:59 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410231547410.11754@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
	 <9e473391041023073578b11eb6@mail.gmail.com>
	 <20041023143912.GA32532@infradead.org>
	 <9e47339104102307441066e4e4@mail.gmail.com>
	 <Pine.LNX.4.58.0410231547410.11754@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 15:48:03 +0100 (IST), Dave Airlie <airlied@linux.ie> wrote:
> > What about the group that will complain about the 30K of memory wasted?
> they'll build their own kernel with CONFIG_AGP turned off... so it won't
> matter...

So the plan then is to eliminate the drm_agp structure and use the
entry points directly. The correct function entry points are already
exported from AGP so no kernel patch is needed.

Dave, with the AGP fix up, do you think linux-core is ready for kernel
submission yet?

-- 
Jon Smirl
jonsmirl@gmail.com
