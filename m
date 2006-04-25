Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWDYHeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWDYHeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWDYHeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:34:04 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:3078 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932096AbWDYHeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:34:02 -0400
Message-ID: <444DD0E7.5070005@argo.co.il>
Date: Tue, 25 Apr 2006 10:33:59 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com> <mj+md-20060424.201044.18351.atrey@ucw.cz>
In-Reply-To: <mj+md-20060424.201044.18351.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 07:34:00.0920 (UTC) FILETIME=[9EDB4580:01C6683A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[original poster de-cc'ed]

Martin Mares wrote:
> Can you name any reasons for why should we support C++ in the kernel?
>   
1. Porting existing modules written in C++ - the trigger for this thread?

2. Shorter, faster, more robust code.
> Why shouldn't we invest the effort to making it possible to write kernel
> modules in Haskell instead?
>   
C++ is a system programming language with good C compatibility. Making 
the kernel compatible with C++ is doable.

Haskell is an excellent language, but it is not a system programming 
language. Kernel programming does not fit well into the functional model.
> The kernel is written in C and its maintainers have so far agreed that
> C is enough and adding any other language brings more pain than gain.
>
> If you think otherwise, feel free to submit some real code which shows
> the advantages of using a different language.
>   
That's certainly doable, however it is quite pointless since we know 
that the code will be rejected regardless of any technical merits it may 
have.

-- 
error compiling committee.c: too many arguments to function

