Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752580AbWAGSWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbWAGSWp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbWAGSWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:22:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752577AbWAGSWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:22:44 -0500
Date: Sat, 7 Jan 2006 10:22:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: git pull on Linux/ACPI release tree
In-Reply-To: <200601071054.37741.len.brown@intel.com>
Message-ID: <Pine.LNX.4.64.0601071017280.3169@g5.osdl.org>
References: <200512010305.43469.len.brown@intel.com> <200512060317.53925.len.brown@intel.com>
 <200512230042.17903.len.brown@intel.com> <200601071054.37741.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Jan 2006, Len Brown wrote:
> 
> please pull this batch of trivial patches from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

Len,

I _really_ wish you wouldn't have those automatic merges.

Why do you do them? They add nothing but ugly and unnecessary history, and 
in this pull, I think almost exactly half of the commits were just these 
empty merges.

There's just no point, except to make the history harder to read.

So please stop it. You have some of the ugliest history around, and it's 
all just because you have some automated process that merges unnecessarily 
all the time.

If you do merges because you want to _test_ the development with a merged 
tree, that doesn't have to happen in the development branch itself. Nobody 
else cares about such a merge except the tester (unless the test fails of 
course, and you need to fix up the result - at which point it's not an 
automated merge any more).

		Linus
