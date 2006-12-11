Return-Path: <linux-kernel-owner+w=401wt.eu-S937518AbWLKSxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937518AbWLKSxd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937541AbWLKSxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:53:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53732 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937518AbWLKSxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:53:32 -0500
Date: Mon, 11 Dec 2006 10:52:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Andy Whitcroft <apw@shadowen.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <20061211184044.GA19244@aepfle.de>
Message-ID: <Pine.LNX.4.64.0612111050040.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <20061211175026.GA18628@aepfle.de>
 <Pine.LNX.4.64.0612111019020.12500@woody.osdl.org> <20061211184044.GA19244@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Olaf Hering wrote:
>
> Of course I could tell it every time what the kernelrelease is, but why
> do I have to?

Because right now, YOUR PIECE OF CRAP IS BUGGY.

Look here, I'm not going to bother explain it to you any more. Do the 

	git grep '".*Linux version .*"'

thing, and if you don't understand why your CRAP IS BUGGY, I don't know 
what else I can tell you.

So I'll make it real simple: I hopefully fixed it this time, but the next 
time somebody happens to have a string that contains "Linux version" in 
it, I simply won't bother. It's not a kernel bug. It's a bug in your 
broken and utterly idiotic process. 

End of discussion.

		Linus
