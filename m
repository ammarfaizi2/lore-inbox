Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbREIUTF>; Wed, 9 May 2001 16:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbREIUSz>; Wed, 9 May 2001 16:18:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55558 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131191AbREIUSm>; Wed, 9 May 2001 16:18:42 -0400
Date: Wed, 9 May 2001 15:40:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <15097.41719.48461.215024@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105091537170.14138-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 May 2001, David S. Miller wrote:

> 
> Marcelo Tosatti writes:
>  > You want writepage() to check/clean the referenced bit and move the page
>  > to the active list itself ?
> 
> Well, that's the other part of what my patch was doing.
> 
> Let me state it a different way, how is the new writepage() framework
> going to do things like ignore the referenced bit during page_launder
> for dead swap pages?

Its not able to ignore the referenced bit. 

I know we want that, but I can't see any clean way of doing that. 

Suggestions ? 

