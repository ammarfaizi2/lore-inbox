Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUDNJne (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 05:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbUDNJne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 05:43:34 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:42134 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263472AbUDNJnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 05:43:32 -0400
Date: Wed, 14 Apr 2004 11:43:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@lacote.name>
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040414094334.GA25975@wohnheim.fh-wedel.de>
References: <200404131744.40098.Guillaume@Lacote.name> <20040413174516.GB1084@wohnheim.fh-wedel.de> <200404140854.56387.Guillaume@Lacote.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404140854.56387.Guillaume@Lacote.name>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 April 2004 08:54:56 +0200, Guillaume Lacôte wrote:
> Le Mardi 13 Avril 2004 19:45, Jörn Engel a écrit :
> 
> Thank you, I didn't know about Jffs2; however I believe it is not an 
> implemendation at the device level as I would like.

Correct.

> Since space efficiency is _not_ my aim I plan to forcibly allocate 3 physical 
> blocks for every 2 "compressed" blocks (as it should (?) always fit with a 
> dynamic Huffman encoding).
> 
> [...]
>
> Oops ! I thought it was possible to guarantee with the Huffman encoding (which
> is more basic than Lempev-Zif) that the compressed data use no more than 1 
> bit for every byte (i.e. 12,5% more space).

Makes sense, although I'd like to see the proof first.  Shouldn't be
too hard to do.

> > Performance should not be a big issue, as encryption is a performance
> > killer anyway.
> I am not sure that this is good news ;)

Is it news? ;)

> > Again, depends on the user.  But from experience, there are plenty of
> > users who want something like this.
> Unfortunately I failed to find substantial code/documentation on encryption 
> plugin for Reiser4, for example. Do you know about some ?

My interest in reiserfs has ceised some time ago.  Have you asked
their list? <reiserfs-list@namesys.com>

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
