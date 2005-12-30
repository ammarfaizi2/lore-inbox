Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVL3IdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVL3IdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVL3IdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:33:16 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:47896 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751217AbVL3IdP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:33:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CfF0T1e45grd5cyFRwNbGO90d0VxFmifdpnAKBPs1b4BgfNEJhC5A0519psz633T44MvdfM/vTgEbYJhafyB0YMYiTTo4SFcNWQhcavS0Oozb2uJgTsdowPMABGM1knTmVa/w52YWdVxY0Gxz+sld7qLsxsFE3GA0zy1ffjUUWI=
Message-ID: <9a8748490512300033occeec40xab3b4f49624c08c5@mail.gmail.com>
Date: Fri, 30 Dec 2005 09:33:14 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
In-Reply-To: <20051229231615.GV15993@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org>
	 <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229231615.GV15993@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Willy Tarreau <willy@w.ods.org> wrote:
<!-- snip -->
>
> Can't we elect a recommended gcc version that distro makers could
> ship under the name kgcc as it has been the case for some time,
> and try to stick to that version for as long as possible ? The only
> real reason to upgrade it would be to support newer archs, while at
> the moment, we try to support compilers which are shipped as default
> *user-space* compilers.
>
As I see it, doing that would
 - put extra work on distributors.
 - bloat users systems with the need to have two gcc versions installed.
 - decrease testing with different gcc versions, which sometimes uncover bugs.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
