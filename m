Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVIHXrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVIHXrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVIHXrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:47:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965079AbVIHXrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:47:51 -0400
Date: Thu, 8 Sep 2005 16:47:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org,
       airlied@gmail.com
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works
 fine.
Message-Id: <20050908164719.00066dc2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
	<20050805104025.GA14688@aitel.hist.no>
	<21d7e99705080503515e3045d5@mail.gmail.com>
	<42F89F79.1060103@aitel.hist.no>
	<42FC7372.7040607@aitel.hist.no>
	<Pine.LNX.4.58.0508120937140.3295@g5.osdl.org>
	<43008C9C.60806@aitel.hist.no>
	<Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> If you remember/save the good/bad commit ID's, you can restart the whole
>  process and just feed the correct state for the ID's:
> 
>  	git bisect start
>  	git bisect bad v2.6.13-rc5
>  	git bisect good v2.6.13-rc4
>  	.. here bisect will start narrowing things down ..
>  	git bisect bad <sha1 of known bad>
>  	git bisect good <sha1 of known good>
>  	..

What do you suggest should be done if you hit a compile error partway
through the bisection search?  Is there some way to go forward or backward
a few csets while keeping the search markers sane?
