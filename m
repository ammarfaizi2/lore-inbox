Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVGPP4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVGPP4H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 11:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVGPP4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 11:56:07 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:52495 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261652AbVGPP4G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 11:56:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CbeCVpo2E2OjpbEcjKTW1YUQCRjKz852eB2YKiksdouK/8a86mxZ/EWYzbZV6ZzX6EAnj3wCLvzSVjOTeEFgdydLniOVBXXYrov3BfebwQNdaTEuLXaPa0nYT/SIy76eQdoOnUNI4gi3FZsxzlq8yibavNHo0LqBKpZwQa3fAK8=
Message-ID: <9a87484905071608565d4b2ec1@mail.gmail.com>
Date: Sat, 16 Jul 2005 17:56:05 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Dhruv Matani <dhruvbird@gmail.com>
Subject: Re: NFS and fifos.
Cc: Arvind Kalyan <base16@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3a9148b905071608496f5c9339@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3a9148b9050716034417d7d148@mail.gmail.com>
	 <90c25f2705071607321d66a776@mail.gmail.com>
	 <3a9148b905071608496f5c9339@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/05, Dhruv Matani <dhruvbird@gmail.com> wrote:
> On 7/16/05, Arvind Kalyan <base16@gmail.com> wrote:
> > On 7/16/05, Dhruv Matani <dhruvbird@gmail.com> wrote:
> > > Hello,
> > >   I can't seem to be able to use fifos on an NFS mount. Is there any
> > > reason why this is disallowed, or is this is a bug? v.2.4.20.
> >
> > Are both the processes (reader/writer) on the same machine? FIFOs are
> > local objects.
> 
> Yes, but I'm accessing them through my remote[public] IP address.
> The idea behind it is to have a fifo that works across the network
> through an NFS mount. Is that possible?
> 
> I serched google for 'socket file', and all that I got was 'fifo', but
> they are to be used only on a singl machine for communication between
> 2 or more applications, but couldn't find any file abstraction for
> communication for processes on distinct machines. Do you know of any
> such thing, cause I couldn't find any.
> 

sockets.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
