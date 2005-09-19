Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVISFHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVISFHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVISFHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:07:19 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:45743 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932252AbVISFHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:07:18 -0400
Message-ID: <432E4786.7010001@namesys.com>
Date: Sun, 18 Sep 2005 22:07:18 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com>	 <200509171415.50454.vda@ilport.com.ua>	 <200509180934.50789.chriswhite@gentoo.org>	 <200509181321.23211.vda@ilport.com.ua>	 <20050918102658.GB22210@infradead.org>	 <b14e81f0050918102254146224@mail.gmail.com> <1127079524.8932.21.camel@localhost.localdomain>
In-Reply-To: <1127079524.8932.21.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>
>It doesn't matter if reiser4 causes crashes. It matters that people can
>fix them, that they are actively fixed and the code is maintainable. It
>will have bugs, all complex code has bugs. Hans team have demonstrated
>the ability to fix some of those bugs fast, but we also all remember
>what happened with reiser3 later on despite early fast fixing.
>  
>
What was that?

>One big reason we jump up and down so much about the coding style is
>that its the one thing that ensures someone else can maintain and fix
>code that the author has abandoned, doesn't have time to fix or that
>needs access to specific hardware the authors may not have.
>
So why is the code in the kernel so hard to read then?

Linux kernel code is getting better, and Andrew Morton's code is
especially good, but for the most part it's unnecessarily hard to read. 
Look at the elevator code for instance.  Ugh.

I differ in one major aspect from some.  That is, the only coding style
requirement I have of those who work for me is that it must be easy to
read.  That is because at every company I can remember where someone was
gungho about advocating that code be written in a specific defined
style, that someone was always the one with the least readable code.

I have a simple punishment for those who violate my requirement: I go
through the code line by line with them, which they always hate for some
reason, and help them comment and clarify it.  1-2 sessions of this, and
they usually change how they code so that they don't have to go through
it again with me.

Asking for readable code is not that different from asking for readable
novels: if you try to define what is required rather than teaching
instance by instance, you can only get in the way of the artist rather
than instructing.

That is why I just say "make it easy to read and I don't care how you do
that so long as it works."

