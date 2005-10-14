Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVJNMCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVJNMCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 08:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVJNMCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 08:02:44 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:18280 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750725AbVJNMCn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 08:02:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o4QNxDURAtVC4DNPklW9i5TBpTk7H0VmNEodxrW145uL+Ky4sVLGB1hc4ohZ1udZhjuQS/6HmoL/d73dhR9RYkVFQAEHlXo3H7PaV8/t6rcp9hyvuVA546r9LLbEmtwBgTOeZfVFJBMWbLBbblwj1y2+yzyjON56AqGlvKld5OM=
Message-ID: <9a8748490510140502p7675c037ie499440b35fabf31@mail.gmail.com>
Date: Fri, 14 Oct 2005 14:02:42 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 01/14] Big kfree NULL check cleanup - net
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <greg@kroah.com>,
       dccp@vger.kernel.org, Patrick Caulfield <patrick@tykepenguin.com>,
       Jean Tourrilhes <jt@hpl.hp.com>, Sridhar Samudrala <sri@us.ibm.com>,
       Andy Adamson <andros@umich.edu>, "J. Bruce Fields" <bfields@umich.edu>,
       Nenad Corbic <ncorbic@sangoma.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
In-Reply-To: <1129283450.5057.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510132125.44470.jesper.juhl@gmail.com>
	 <1129283450.5057.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jesper,
>
> > This is the net/ part of the big kfree cleanup patch.
> >
> > Remove pointless checks for NULL prior to calling kfree() in net/.
> >
> >
> > Sorry about the long Cc: list, but I wanted to make sure I included everyone
> > who's code I've changed with this patch.
>
> you forgot me ;)
>

Sorry. I did try to include everyone, but there were so many different
areas and so many different persons that it was practically impossible
not to miss one or two people - surely was not intentional :)

[snip]
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>
Thank you for that.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
