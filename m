Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266102AbTLIUTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbTLIUSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:18:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:37280 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266102AbTLIUP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:15:29 -0500
Date: Tue, 9 Dec 2003 19:15:30 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       Nikita Danilov <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
Message-ID: <20031209191530.GA30766@mail.shareable.org>
References: <200312081646.42191.arnd@arndb.de> <Pine.LNX.4.58.0312082321470.18255@home.osdl.org> <3FD57C77.4000403@zytor.com> <200312091256.47414.arnd@arndb.de> <3FD5ED77.6070505@zytor.com> <Pine.LNX.4.58.0312090837370.19936@home.osdl.org> <3FD5FD8C.7010608@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD5FD8C.7010608@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Agreed.  It's just a bit ugly that the "m" in "rm" has a different 
> meaning than just "m".

Oh?  What does the "m" in "m,m" mean then?

(I don't have GCC 3.3 to try it here).

Sometimes that's useful, when used with differing multi-alternative
constraints on the other arguments, and 99% of the time you _do_ want
the "m,m" constraint to use the actual lvalue's address just like "m".

-- Jamie
