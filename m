Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVKBExE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVKBExE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 23:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbVKBExE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 23:53:04 -0500
Received: from dvhart.com ([64.146.134.43]:23722 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751493AbVKBExD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 23:53:03 -0500
Date: Tue, 01 Nov 2005 20:53:08 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: pj@sgi.com, ak@suse.de, tytso@mit.edu, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <219800000.1130907187@[10.10.2.4]>
In-Reply-To: <20051031072714.GU7992@ftp.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <p73r7a4t0s7.fsf@verdi.suse.de> <20051030213221.GA28020@thunk.org> <200510310145.43663.ak@suse.de> <20051031001810.GQ7992@ftp.linux.org.uk> <20051030191402.669273d5.pj@sgi.com> <20051031033426.GT7992@ftp.linux.org.uk> <20051030232234.3ebf77c8.akpm@osdl.org> <20051031072714.GU7992@ftp.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> fud.  Every -mm release is built with allmodconfig on x86 and on x86_64. 
>> It's also cross-compiled on fat configs for alpha, ppc32, ppc64, sparc64,
>> arm and ia64.  It's booted on x86, x86_64, ppc64 and ia64.  Every release.
> 
> What fud?  I stand by my claim - I have tried to do the same thing for
> -mm and found that I didn't have guts for that; too much work.  For mainline
> I do cross-builds for allmodconfig on a *lot* more targets than what you've
> mentioned and generally it stays within ~150-200Kb of patches, about half
> of that being a fix for 8390 mess.
> 
> _IF_ somebody wants to do that for -mm, yell and you are more than welcome
> to all infrastructure, except for the cycles on build box I'm using.
> Incidentally, it is a box at work - my energy bill is high enough as it
> is, without adding an 8-way 3GHz iamd64 to it...

I'll do that if you want. I have a big lab full of largish boxes with 
serious aircon, and IBM can afford the power bill. I'm assuming this 
is a farm of cross-compilers that'll run on x86 (or x86_64)?

M.

