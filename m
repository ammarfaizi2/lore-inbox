Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWIKTzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWIKTzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWIKTzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:55:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:53862 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932278AbWIKTzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:55:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iroHlQzTocdoGDnZ7SpIse2LeSpj+FiGsygpdvcVO5wPGOiZMJSErOQlp3Kr6x9mGlol4LGBz84Px8O99JJkyCcGMtt3abZ32jrWs+wk5lgz+PW7JVGfm+tahPo65wBuxZf2W9ZbzHTcIWL+oWMmb/oNqOBZH4Yh/jftFdKf8gk=
Message-ID: <9a8748490609111255w2961d34bo63fb0db7d0d4190a@mail.gmail.com>
Date: Mon, 11 Sep 2006 21:55:30 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Marc Perkel" <marc@perkel.com>
Subject: Re: Segfault Error - what does this mean?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4505B788.1030803@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4505B788.1030803@perkel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/06, Marc Perkel <marc@perkel.com> wrote:
> Just put a new server online trying out the new AMD AM2 processor. I compiled a custom kernel because the regular Fedora Core kernels aren't yet compatible with my Asus M2NPV-VM motherboard using the nVidia chipset.
>
> I compiled 2.6.18rc6 and got segfault errors. So I tried the 2.6.17.13 kernel and same thing. About every 20 minutes or so I get one of these.
>
> Sep 11 12:05:18 pascal kernel: exim[19840]: segfault at 0000000000000000 rip 0000003f53e73ee0 rsp 00007fff9e561d18 error 4
>
> At one point the server locked up. Before I put it online I did several days of memory testing with no errors. I believe the Exim code is solid as it has been running flawlessly on all my other servers.
>
> It's probably hardware or some incompatibility but I'm not sure where to start looking. Trying to understand what this error means. What is Error 4? How do I track this down?
>

Hi, I don't have a solution to your problem unfortunately, just want
to give you a bit of advice.

1) Try searching the archives and google a bit for info before posting
(and when you do post, make it clear that you've done so). As it turns
out this problem has surfaced before and there are several
interresting threads on the subject - here are a few I found (there
are others) :
http://lkml.org/lkml/2005/9/8/4
http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-06/3234.html
http://www.mhonarc.org/archive/html/procmail/2006-06/msg00140.html

2) If you find previous posts related to your problem you'll often see
requests for specific info in them (like Andi asking "... catch a
crash in gdb and type x/i $pc what do you see?" in
http://lkml.org/lkml/2005/9/8/17 ). Try to provide such info in your
initial post - it'll greatly enhance your chances of getting useful
replies (and/or getting the bug fixed).

3) Please read the REPORTING-BUGS document in the root of the kernel
source dir and provide the info it outlines - usually saves a bunch of
ping-pong mails back and forth asking for more info.

4) Try to add people who may have an insight into the problem to Cc: -
looking at previous threads on the subject and finding the people who
have previously shown an interrest is usually a good starting point.
The right people may miss your report if you only send to LKML.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
