Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWJVWvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWJVWvU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWJVWvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:51:20 -0400
Received: from web55609.mail.re4.yahoo.com ([206.190.58.233]:37772 "HELO
	web55609.mail.re4.yahoo.com") by vger.kernel.org with SMTP
	id S1750827AbWJVWvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:51:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ny7/AWzIgNkUZtYVFE/eFShUAhRU8TFE9Awojkrf2V+FQHIMQzIU+M/185McdUxADrHl4xDPN/fd/iikCrerHfKaWFHmlKJnL5jm7lWhP7nnfnHLafZOFZGqgUCK3QUDkaAqlYKtG2+lUT7s8xB98M2YWh6Cc8EjX25Wjn9Y0aw=  ;
Message-ID: <20061022225118.6405.qmail@web55609.mail.re4.yahoo.com>
Date: Sun, 22 Oct 2006 15:51:18 -0700 (PDT)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: Hopefully, kmalloc() will always succeed, but if it doesn't then....
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <84144f020610221322v2683a66bmf837ada1edea72e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> On 10/22/06, Amit Choudhary <amit2030@yahoo.com> wrote:
> > So, if memory allocation to 'a' fails, it is going to kfree 'b'. But since 'b'
> > is not initialized, kfree may crash (unless DEBUG is defined).
> >
> > I have seen the same case at many places when allocating in a loop.
> 
> So you found a bug. Why not send a patch to fix it?
> 

Yes, I will send it.

Regards,
Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
