Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVFUVTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVFUVTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVFUVS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:18:27 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:43459 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262307AbVFUVDH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:03:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t3bdR4QbH4GHASutQ9iU7eArWzIH7RYA4psEi067Qr2iRe3ZOfHBnmrDIJA6jCD2bCt/9XziFuagwpe+IcxVI5prB15Xmn2CnR+4sVzVR7cokAhe6MzevcSh/DnXIYc5RoPwAwjAANlExWbeo681MhLBof7CuboXYV0Y0H1JVnY=
Message-ID: <9a874849050621140371b6b5d@mail.gmail.com>
Date: Tue, 21 Jun 2005 23:03:06 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: [patch] correct an email address
Cc: trivial@rustcorp.com.au, linux-kernel <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <42B87CD6.2060102@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42B87CD6.2060102@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Christian Kujau <evil@g-house.de> wrote:
> hello,
> 
> i tried to send the forcedeth maintainer an email, but it came back with:
> 
> "The mail address manfreds@colorfullife.com is not read anymore.
> Please resent your mail to manfred@ instead of manfreds@."
> 
> this attached patch tries to fix it.
> 
As far as I know (at least that's what akpm told me last I submitted a
similar patch) it's prefered that email addresses are listed in
CREDITS and MAINTAINERS only and when addresses change and need to be
updated that's a perfect time to get them out of the source and into
the proper location.
And seeing that Manfred's address in CREDITS is already correct, I
believe a patch that simply replaces "Manfred Spraul
<manfred@colorfullife.com>" with "Manfred Spraul" in the source files
would be better.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
