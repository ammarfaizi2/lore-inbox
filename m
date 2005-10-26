Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVJZAuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVJZAuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 20:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVJZAuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 20:50:08 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:38067 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932510AbVJZAuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 20:50:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Ds7rEj0tZvml1zEDmO1DCjAi3l6jFj8RYc0Ri7KjZcO9nXM3ZqJGhNjeTnnTFA9Tjs4xKxK6M32Ga7GNM5SGQpdDxSGBfNqjS1hLNXRWsSCiFIuHepeFAIYsj3qK35slpmpvlkYbc60qWsELhLTIwaV/24EMv7R4qDTycC13MdA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH 01/11] uml: sigio code - reduce spinlock hold time
Date: Wed, 26 Oct 2005 02:54:13 +0200
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>
References: <20051025220053.20010.56979.stgit@zion.home.lan> <9a8748490510251717n613aab40r84ef1f66abc6b5be@mail.gmail.com>
In-Reply-To: <9a8748490510251717n613aab40r84ef1f66abc6b5be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260254.14546.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 02:17, Jesper Juhl wrote:
> On 10/26/05, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> wrote:
> [snip]
>
> > And fix whitespace, at least for things I was touching anyway.
>
> [snip]
>
> > +       return;
> > +
> >  }

> Why an extra blank line at the end of the function?
Forgot to remove that blank line, sorry.

Jeff, remove when merging in your tree if you don't forget.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
