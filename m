Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbRFGTNy>; Thu, 7 Jun 2001 15:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbRFGTNp>; Thu, 7 Jun 2001 15:13:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34569 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262901AbRFGTNf>; Thu, 7 Jun 2001 15:13:35 -0400
Date: Thu, 7 Jun 2001 14:38:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] Reap dead swap cache earlier v2
In-Reply-To: <l0313031cb745811cfc17@[192.168.239.105]>
Message-ID: <Pine.LNX.4.21.0106071435580.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Jonathan Morton wrote:

> >As suggested by Linus, I've cleaned the reapswap code to be contained
> >inside an inline function. (yes, the if statement is really ugly)
> 
> I can't seem to find the patch which adds this behaviour to the background
> scanning.  

I've just sent Linus a patch to free swap cache pages at the time we free
the last pte. (requested by himself)

With it applied we should get the old behaviour back again. 

I can put it on my webpage if you wish. 

