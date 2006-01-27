Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWA0S5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWA0S5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWA0S5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:57:45 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:36677 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751546AbWA0S5o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:57:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JIPYxC8kkQGW8lLGy0yNIAnw0e9mJAri2kiPsTXuVdu0tl0+xa4+2qnBehSyUi9lxhQwCHqmvfZe16GdiwyF5MvM3VpRORi7QV0pNDEMvgYFU+IvUSVEajZ0GQaWKTv8FlfaDeyos1KZMFxC4IfI8cSDclFZqtk8mS9Jn4KbM/8=
Message-ID: <9a8748490601271057y709d3501ob278c85b104eef57@mail.gmail.com>
Date: Fri, 27 Jan 2006 19:57:38 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Gerold van Dijk <gerold@sicon-sr.com>
Subject: Re: traceroute bug ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000601c62370$db00cd50$1701a8c0@gerold>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <000601c62370$db00cd50$1701a8c0@gerold>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/06, Gerold van Dijk <gerold@sicon-sr.com> wrote:
> Why can I NOT do a traceroute specifically within my own (sub)network
>
> 207.253.5.64/27
>
> with any distribution of Linux??
>

Because you configured your machines to drop icmp packets perhaps.
Some router on your network may be dropping icmp packets.
You've configured the network incorrectly.
There are several possible reasons, but I don't see what it has to do
with the kernel at this point?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
