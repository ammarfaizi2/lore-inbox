Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293453AbSCOW4P>; Fri, 15 Mar 2002 17:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293452AbSCOW4F>; Fri, 15 Mar 2002 17:56:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19617 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293448AbSCOWzy>;
	Fri, 15 Mar 2002 17:55:54 -0500
Date: Fri, 15 Mar 2002 14:53:06 -0800 (PST)
Message-Id: <20020315.145306.15914579.davem@redhat.com>
To: davids@webmaster.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020315223649.AAA27488@shell.webmaster.com@whenever>
In-Reply-To: <20020315223649.AAA27488@shell.webmaster.com@whenever>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is no reason to not be doing this MD5 garbage in
userspace.  Whoever thought to do this in the protocol
itself was smoking something.

And if people want encryption they can use ipsec.  And if
ipsec is broken it should be fixed because adding a new
abomination to MD5.

Maybe I'm missing something, but I see no reason this MD5
stuff belongs in the protocol and not in the APP.
