Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVIEQWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVIEQWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVIEQWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:22:48 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:39860 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750971AbVIEQWr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:22:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YKqPKJ/YmX+3l2ijY4/4YHt6Fnp+T2L0wRmP3kNY0XHnKw6UcdUMY/t7nHW79QNa9DEDnQHw2YJidNFXAV0ZmcPcEz5dQVevuYoosT/W8+2qnQ11V+MNbZygwkZiw7j7lZ5aZtMuk0uz4aXwdy8IZT/uWWdSNavlSH5PL2lPBO8=
Message-ID: <9a874849050905092279e8e860@mail.gmail.com>
Date: Mon, 5 Sep 2005 18:22:46 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "felix-linuxkernel@fefe.de" <felix-linuxkernel@fefe.de>
Subject: Re: igmp problem
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20050905155640.GA18216@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050905155640.GA18216@codeblau.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, felix-linuxkernel@fefe.de <felix-linuxkernel@fefe.de> wrote:
> Hi!
> 
> I wrote a few multicast tools, which use these multicast groups:
> 
>   225.109.99.112
>   ff02::6d63:7030
>   224.110.99.112
>   ff02::6e63:7030
> 
> I have a Cisco in the middle, and both boxes are in different VLANs.
> The Cisco is sending out igmp queries.  The kernel never answers, even
> after subscribing to these multicast groups.
> 
> The kernel version is 2.4.26.  What could be the problem here?
> 
> I found no netfilter rules, and the kernel has multicast support (at
> least several igmp related sysctls exist).
> 

I'm unfortunately not able to help you with your specific problem, but
a few words of advice: you really ought to start by reproducing the
problem with a recent kernel - like 2.4.31 or 2.6.13.
2.4.26 is really ancient and noone really cares about it any more.

You should probably also talk to the netdev people (CC'ed).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
