Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTKITEd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTKITEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:04:33 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:11400 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262766AbTKITEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:04:32 -0500
Message-ID: <3FAE9026.60500@stesmi.com>
Date: Sun, 09 Nov 2003 20:06:14 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: Some thoughts about stable kernel development
References: <m3u15de669.fsf@defiant.pm.waw.pl>
In-Reply-To: <m3u15de669.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krysztof.

> As all of you know, the development cycle can be shortened by using
> two separate trees for a stable kernel line.
> 
> Say, we're now at 2.4.23-rc1 stage. This "rc" kernel would also be
> known as 2.4.24-pre1. The maintainer would apply "rc"-class fixes to
> both kernels, and other patches (which can't go to "rc" kernel) would
> be applied to 2.4.24-pre1 only.
> 
> After 2.4.23-rcX becomes final 2.4.23, the 2.4.24-preX would become
> 2.4.24-rc1 and would be a base for 2.4.25-pre1.

And then someone comes along and says that feature X isn't working in
some version. He then reports that "it worked in a.b.c but then someone
broke it for a.b.c+1 pre 1. Then you have to tell that person that
a.b.c+1 pre 1 isn't newer than a.b.c. Messy. Very messy.
The list gets too many mails that are answered by "RTFM" already.

// Stefan

