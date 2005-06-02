Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVFBJra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVFBJra (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVFBJra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:47:30 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:10959 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261343AbVFBJrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:47:22 -0400
Date: Thu, 2 Jun 2005 11:47:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: XIAO Gang <xiao@unice.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
Message-ID: <20050602094714.GA3218@wohnheim.fh-wedel.de>
References: <429EB537.4060305@unice.fr> <20050602084840.GA32519@wohnheim.fh-wedel.de> <429ECD6D.8000503@unice.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429ECD6D.8000503@unice.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 June 2005 11:12:13 +0200, XIAO Gang wrote:
> >
> I know; I might try to do something later. The question here is to find 
> the best balancing point between what
> are better replaced and what are not. I would hesitate a lot before 
> doing things as below which are more likely to introduce new bugs than 
> to avoid old ones.

In some cases a comment like "this sucks, but we have to do it
because.." helps.  Example 2 can also be changed to size_t, that one
makes sense.

"grep 'int len'" really is a decent code checker, I agree.  The hard
part is finding the 2% real problems among the output.  And possibly
other cases where s/int/size_t/ doesn't fix anything, but makes
slightly more sense.

Jörn

-- 
Man darf nicht das, was uns unwahrscheinlich und unnatürlich erscheint,
mit dem verwechseln, was absolut unmöglich ist.
-- Carl Friedrich Gauß
