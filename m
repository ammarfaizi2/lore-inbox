Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbVK2PRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVK2PRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVK2PRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:17:50 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:14383 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751376AbVK2PRt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:17:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ShrdMoOfF4RE3FzLDpSWJ+p+GJLT2xz9b7tVFb09WS+qjztDemmaHnV9+B5BeEPYQDhbM+M2yNXdFOngpq5Z8aOE5S4aukmjXDw9hYjmqFTaaEv5FDdElts0QyRAUSPJ/FXuLlauuBkSWNFUmB8Hc6BnK4wcBdtAlAI8tkMtSGc=
Message-ID: <9a8748490511290717o4d4caa8fi47b9103d0f5ea80b@mail.gmail.com>
Date: Tue, 29 Nov 2005 16:17:49 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: [PATCH] hpfs: Whitespace and Codingstyle cleanup for dir.c
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <Pine.LNX.4.62.0510121327580.28884@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510121326.52216.jesper.juhl@gmail.com>
	 <Pine.LNX.4.62.0510121327580.28884@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/05, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
>
>
> On Wed, 12 Oct 2005, Jesper Juhl wrote:
>
> > Whitespace and CodingStyle cleanup for fs/hpfs/dir.c
> >
> > While reading through fs/hpfs/dir.c I ran across lots of cases of multiple
> > statements on a single line that made some bits of the file quite confusing
> > to read. This patch cleans that up and also make sure labels are placed at
> > column 1, removes trailing whitespace and a few other minor CodingStyle nits.
>
> I don't see anything wrong with
>         if (some_condition) do_some_action();
> statements. Generally, if they consume less lines, you can see more code
> on a screen.
>
> Mikulas
>

Well, as Pekka Enberg also pointed out, Documentation/CodingStyle says
that's not the prefered way. But, it's your code, so if you don't like
the cleanups don't apply them.
i still think the patch is a good idea and makes the file more readable though.


> > There are some very long lines in this file that would be a lot more readable
> > (IMHO) if broken up to fit within 80 cols. This patch does not do that, but
> > if wanted I can submit an aditional patch on top of this one to do that.
> >
Same with this bit, IMHO a good idea, but I won't bother making a
patch if you don't want it.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
