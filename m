Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbUK2WjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbUK2WjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbUK2WgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:36:11 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36804 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261845AbUK2WdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:33:21 -0500
Date: Mon, 29 Nov 2004 14:33:12 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 3/10 CKRM:  Core ckrm, rcfs
Message-ID: <20041129223312.GA20667@kroah.com>
References: <E1CYqYe-00057g-00@w-gerrit.beaverton.ibm.com> <20041129220047.GC19892@kroah.com> <527jo4s31r.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527jo4s31r.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 02:28:32PM -0800, Roland Dreier wrote:
>     Greg> Ick.  Don't put a _t at the end of a typedef.  Wrong OS
>     Greg> style guide.
> 
> Just out of curiousity, who wrote the line
> 
> 	typedef int __bitwise kobject_action_t;
> 
> in <linux/kobject_uevent.h>?  From the changelog it almost looks like
> you did it ;)

Yeah, at Linus's insistance.  See his email about the whole __bitwise
stuff for that :(

But I did it for a simple variable type.  Not a structure.

/me justifies it to himself somehow...

greg k-h
