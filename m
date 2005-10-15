Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVJOUWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVJOUWX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 16:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVJOUWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 16:22:23 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:38336 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751216AbVJOUWX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 16:22:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q5zVvajME0eAlUx0rDiCNkwjj03NLc1J8tMPtXQghC6iiBfL5FFvJgznnKvPQ2AJx9UNuiJXtkpj626E9U2Uk8VzfIyAyyeturvOSXaqdNB1jpF/a0Psx3JKRL+GBlZnhxvI06aZb5AvWrTO6q6+9Qfd69CjtHc+k9/6m1OXU0I=
Message-ID: <9a8748490510151322w25063287u567ecb698037fc4d@mail.gmail.com>
Date: Sat, 15 Oct 2005 22:22:22 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: Some problems with 2.6.13.4
Cc: Christian Kujau <evil@g-house.de>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Aubry <kernel-obri@chaostreff.ch>
In-Reply-To: <20051015200245.GM12774@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051015122131.GG8609@schottelius.org>
	 <43511AB1.3010608@g-house.de> <20051015154048.GK8609@schottelius.org>
	 <20051015200245.GM12774@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
[snip]
> Could we somehow debug this differently or do I have to install
> 2.6.13.2 and 2.6.13.1, too? It would take simply hours until it is
> finished here.
>

If you have another, faster, machine available you could build the
kernel(s) on that one. You don't have to build a kernel on the same
machine that is later supposed to run it.
Also, if you have more than one machine (even if they are not
especially fast) then you can use distcc (http://distcc.samba.org/) to
distribute the build over multiple machines which can speed up a build
a great deal.

[snip]

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
