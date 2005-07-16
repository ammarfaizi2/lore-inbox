Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVGPPvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVGPPvB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 11:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVGPPvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 11:51:00 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:41739 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261666AbVGPPu6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 11:50:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e6EXR3KxsGuHkcva6QMzkWufmH/hafbqgLiH93EvFZemM3I+Z3g8p2NT9ttvTiEe5SGIB0vUlOdCXQUUBTdos4iHn8AFYNk20lZ0A6TnyyvHjAuHYE/NoDbY6MU+WhMYI3NIHS8v7K/XiOrM/+FKWPkuUq+ghxsETOHOyOyD+SE=
Message-ID: <3a9148b905071608496f5c9339@mail.gmail.com>
Date: Sat, 16 Jul 2005 21:19:52 +0530
From: Dhruv Matani <dhruvbird@gmail.com>
Reply-To: Dhruv Matani <dhruvbird@gmail.com>
To: Arvind Kalyan <base16@gmail.com>
Subject: Re: NFS and fifos.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <90c25f2705071607321d66a776@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3a9148b9050716034417d7d148@mail.gmail.com>
	 <90c25f2705071607321d66a776@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/05, Arvind Kalyan <base16@gmail.com> wrote:
> On 7/16/05, Dhruv Matani <dhruvbird@gmail.com> wrote:
> > Hello,
> >   I can't seem to be able to use fifos on an NFS mount. Is there any
> > reason why this is disallowed, or is this is a bug? v.2.4.20.
> 
> Are both the processes (reader/writer) on the same machine? FIFOs are
> local objects.

Yes, but I'm accessing them through my remote[public] IP address.
The idea behind it is to have a fifo that works across the network
through an NFS mount. Is that possible?

I serched google for 'socket file', and all that I got was 'fifo', but
they are to be used only on a singl machine for communication between
2 or more applications, but couldn't find any file abstraction for
communication for processes on distinct machines. Do you know of any
such thing, cause I couldn't find any.


> 
> --
> Arvind Kalyan
> http://www.devforge.net/~arv
> 


-- 
   -Dhruv Matani.
http://www.geocities.com/dhruvbird/

The race of quality has no finish line.
	~Anon.
