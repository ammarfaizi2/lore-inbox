Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVFQSs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVFQSs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVFQSs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:48:29 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:16476 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262055AbVFQSsS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:48:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pxxfygj7kyQaWZ1FSOmTFDn4fMwMuTS/5b8FFQ8N0oJNGrj/vxjqBfjv/4vm1eeAzKdYDmxpDB9Dk2EDqCNg9wnM3uTC9k3BKnHNj7Lzps48q9NngOlVrgyq9wtROC2OZDCIF3AE9JWGlzG/PKt6ncynSnUqTIyfDt+WcGpjw9M=
Message-ID: <9a87484905061711481f706662@mail.gmail.com>
Date: Fri, 17 Jun 2005 20:48:16 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Charles Leggett <CGLeggett@lbl.gov>
Subject: Re: system hangs with no warning or errors
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1119033617.4663.90.camel@annwm.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1119033617.4663.90.camel@annwm.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/05, Charles Leggett <CGLeggett@lbl.gov> wrote:
> 
> I'm running a dual opteron, debian unstable based system, which hangs
> at random intervals with no errors being written to any of the log
> files. I'm currently using a 64 bit kernel 2.6.11-rc5, but I've seen
> this behaviour with a series of kernels since 2.6.9. Sometimes the
> system sometimes runs for several weeks between hangs, and sometimes
> hangs twice in a day. When it hangs, the screen freezes, and is
> completely unresponsive to all keyboard/mouse input, and will not
> respond to pings over the network. It is not an X problem.
> 
> I was previously running CentOS with a 2.4.21 kenel for several months,
> and experienced no problems, so I don't think it is a hardware problem.
> 
> I know that this is a very anemic bug report, I'm sorry I can't offer
> any more information. Any suggestions for things to look for, what
> to instrument to get more detailed information, or things to try are
> welcome.
> 
The very first thing I would try would be to try the most recent
kernels; the stable kernel 2.6.11.12 and the development kernels
2.6.12-rc6, 2.6.12-rc6-git8 & 2.6.12-rc6-mm1  to see if the issue has
already been addressed.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
