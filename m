Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130438AbRCGImH>; Wed, 7 Mar 2001 03:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130445AbRCGIls>; Wed, 7 Mar 2001 03:41:48 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16310 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130438AbRCGIlk>;
	Wed, 7 Mar 2001 03:41:40 -0500
Date: Wed, 7 Mar 2001 03:40:58 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeremy Elson <jelson@circlemud.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another? 
In-Reply-To: <200103070813.f278DUw06475@servo.isi.edu>
Message-ID: <Pine.GSO.4.21.0103070337560.2127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2001, Jeremy Elson wrote:

> Right now, my code looks something like this: (it might make more
> sense if you know that I've written a framework for writing user-space
> device drivers... I'm going to be releasing it soon, hopefully after I
> resolve this performance problem.  Or maybe before, if it's hard.)

Ugh. Why not make that a named pipe and use zerocopy stuff for pipes?
I.e. why bother with making it look like a character device rather than
a FIFO?
							Cheers,
								Al

