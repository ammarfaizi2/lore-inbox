Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269313AbUJQUfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269313AbUJQUfm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJQUcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:32:11 -0400
Received: from relay.pair.com ([209.68.1.20]:18696 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269289AbUJQUbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:31:09 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4172C949.2020506@kegel.com>
Date: Sun, 17 Oct 2004 12:34:33 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Building on case-insensitive systems
References: <1097989574.2674.14246.camel@cube> <4171F741.2070209@kegel.com>	 <1097991836.2666.14274.camel@cube>	 <20041017092730.GA9081@mars.ravnborg.org>	 <1098035748.2666.14288.camel@cube>  <4172A8FD.8000401@kegel.com> <1098042896.2669.14306.camel@cube>
In-Reply-To: <1098042896.2669.14306.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> Since MacOS can handle case-sensitive UFS filesystems,
> and it has just been reported that Microsoft SFU also
> supports being case-sensitive, the problem is solved.

Not really; switching to UFS or to SFU (how often are
two unrelated acronyms in the same sentence anagrams of
each other?) is unpleasant for users accustomed to
plain old MacOSX with HFS or Windows with Cygwin.
(And politically speaking, SFU could be yanked by
Microsoft at any time, whereas Cygwin will always be
free, so I tend to support Cygwin and ignore SFU.
I have a copy of SFU, though, and if somebody asks
me to support it, I would reconsider.  Nobody has yet.)

But the .S/.s ambiguity can be worked around easily
by building with 'make O=someotherdir', which is
a good idea anyway, so I'm not too worried about
it at the moment.  (I'm more annoyed at ambiguities
in source file names in netfilter; see
https://lists.netfilter.org/pipermail/netfilter-devel/2004-October/017145.html)
- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
