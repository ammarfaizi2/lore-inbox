Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271769AbRIQIOY>; Mon, 17 Sep 2001 04:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273526AbRIQIOP>; Mon, 17 Sep 2001 04:14:15 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:26116 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271769AbRIQIOH>; Mon, 17 Sep 2001 04:14:07 -0400
Date: Mon, 17 Sep 2001 10:14:28 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac11
Message-ID: <20010917101428.E7717@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200109170049.f8H0nkEa008317@sleipnir.valparaiso.cl> <m366ail5pp.fsf@giants.mandrakesoft.com> <shsvgiicl7l.fsf@charged.uio.no> <20010917095640.C4490@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010917095640.C4490@werewolf.able.es>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, J . A . Magallon wrote:

> 
> On 20010917 Trond Myklebust wrote:
> >
> >That particular code is only called if something closes a file on
> >which POSIX locks are applied. Init doesn't use locking.
> >The patch *is* required in Alan's tree. Without it, 2 processes that
>                 ^^^^^^^^ ???
> >lock the same file can race and corrupt the i_flock list.
> >
> 
> I have checked and I suppose you want to say that it is INCLUDED in
> Alan's tree...

Translation to clear text: it must not be dropped from Alan's tree.
