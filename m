Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWEUKpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWEUKpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 06:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWEUKpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 06:45:39 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:35799 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751524AbWEUKpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 06:45:39 -0400
Message-ID: <01af01c67cc3$a399cb30$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs> <20060521091022.GA3468@taniwha.stupidest.org> <014601c67cb9$4f235f30$1800a8c0@dcccs> <20060521102407.GA5582@taniwha.stupidest.org>
Subject: Re: swapper: page allocation failure.
Date: Sun, 21 May 2006 12:42:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Chris Wedgwood" <cw@f00f.org>
To: "Haar J?nos" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 21, 2006 12:24 PM
Subject: Re: swapper: page allocation failure.


> On Sun, May 21, 2006 at 11:31:12AM +0200, Haar J?nos wrote:
>
> > 1. why don't use highmem for caching?
> > 2. why can not allocate enough lowmem from shared-buffer for the e1000
> > driver if it needs some memory?
>
> highmem can't be used as freely as lowmem, it has additional
> complexity and a slight over head that makes it hard or impossible to
> use in many places

OK, i understand this, but buffer-cache is an optional thing, and looks like
really simple (for me), and i cannot understand why cannot use exactly for
buffering the highmem...

On my concentrator the nbd-client uses ~ 3.5GB of ram for PAGE-cache.
The buffer cache why can not use the highmem?
Whats the difference?

Cheers,
Janos

