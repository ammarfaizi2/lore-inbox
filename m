Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVJ2UJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVJ2UJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVJ2UJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:09:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25251 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751370AbVJ2UJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:09:28 -0400
Date: Sat, 29 Oct 2005 21:09:24 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
Message-ID: <20051029200924.GM7992@ftp.linux.org.uk>
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org> <4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 12:37:58PM -0700, Linus Torvalds wrote:
> Now, I've gotten several positive comments on how easy "git bisect" is to 
> use, and I've used it myself, but this is the first time that patch users 
> _really_ become very much second-class citizens, and you can't necessarily 
> always do useful things with just the tar-trees and patches. That's sad, 
> and possibly a really big downside.
> 
> Don't get me wrong - I personally think that the new merge policy is a 
> clear improvement, but it does have this downside.

Well...  All it takes is extra patches when incremental gets too large;
e.g. have a script pick idle interval close to splitting the thing in
half until parts get less than <size>.  The question is, how much extra
load would that create?  Another problem is that a lot of intermediates
will not build, but that is just as true for -git<n> snapshots ;-/
