Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVDRVml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDRVml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVDRVml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 17:42:41 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:50190 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261159AbVDRVmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 17:42:39 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Mon, 18 Apr 2005 21:40:37 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d419gl$qvq$2@abraham.cs.berkeley.edu>
References: <20050414141538.3651.qmail@science.horizon.com> <d3poiv$vrn$2@abraham.cs.berkeley.edu> <20050418191316.GL21897@waste.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113860437 27642 128.32.168.222 (18 Apr 2005 21:40:37 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 18 Apr 2005 21:40:37 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall  wrote:
>On Sat, Apr 16, 2005 at 01:08:47AM +0000, David Wagner wrote:
>> http://eprint.iacr.org/2005/029
>
>Unfortunately, this paper's analysis of /dev/random is so shallow that
>they don't even know what hash it's using. Almost all of section 5.3
>is wrong (and was when I read it initially).

Yes, that is a minor glitch, but I believe all their points remain
valid nonetheless.  My advice is to apply the appropriate s/MD5/SHA1/g
substitution, and re-read the paper to see what you can get out of it.

The problem is not that the paper is shallow; it is not.  The source
of the error is likely that this paper was written by theorists, not
implementors.  There are important things we can learn from them, and I
think it is worth reading their paper carefully to understand what they
have to offer.

I believe they raise substantial and deep questions in their Section 5.3.
I don't see why you say Section 5.3 is all wrong.  Can you elaborate?
Can you explain one or two of the substantial errors you see?
