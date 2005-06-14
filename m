Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFNQkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFNQkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFNQkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 12:40:21 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:8730 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261247AbVFNQkE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 12:40:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t/qRuxBx7LtsdKajfaYZRRL3/mFHmudrPW57e00qdrGKgubML1B1UC+lS+8GVpDUe+dsbtiRwzxCYt+lZjWkeZcU+4tiNkLwKEzBadBUXoXlCFfCdv+8oLFYLEu5ZOhiPBwAUQWeV7yT5K2PMqjBOtWU7AZhMIsuBMtiKu+5C8U=
Message-ID: <9a874849050614093925f95837@mail.gmail.com>
Date: Tue, 14 Jun 2005 18:39:58 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net: fix sparse warning (plain int as NULL)
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org, ross.biro@gmail.com,
       netdev@vger.kernel.org
In-Reply-To: <20050613.143114.35469427.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506122358570.16521@dragon.hyggekrogen.localhost>
	 <20050613.135950.48528369.davem@davemloft.net>
	 <9a8748490506131421707008ed@mail.gmail.com>
	 <20050613.143114.35469427.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/05, David S. Miller <davem@davemloft.net> wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> Date: Mon, 13 Jun 2005 23:21:56 +0200
> 
> > Since tcp_ack_saw_tstamp() in 2.6.12-rc6-git6 only takes two arguments
> > this patch is only relevant for -mm.
> 
> Thanks for the clarification.
> 
You are welcome. Should I just send the patch on to Andrew for inclusion, or?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
