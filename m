Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965362AbWJ2UXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965362AbWJ2UXn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965367AbWJ2UXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:23:42 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:21349 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965362AbWJ2UXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:23:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=EI1QaJEfS6qjfJZtjrRZQUTMKxE5YJQSJ2/6mBwW2Q9hjRJ3k/sFfxjp/EBnfLDyWz8aPVLvVnrQH1V7ou52gEE/qXAKzVoyuakPj6zrCJnhshtA3xeocCmf4nPwlFHMAays24KQ7SJc0KDKaMyuSL3xwGQLNEaiQDBln6wp4r4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 00/11] UBD driver little cleanups for 2.6.19
Date: Sun, 29 Oct 2006 21:23:43 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan> <20061029120224.d25e3204.akpm@osdl.org>
In-Reply-To: <20061029120224.d25e3204.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610292123.43606.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 October 2006 21:02, Andrew Morton wrote:
> On Sun, 29 Oct 2006 20:17:23 +0100
>
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > Many cleanups for the UBD driver; these are mostly microfixes, I was
> > waiting to finish and reorder also locking fixes (the code works, it is
> > only to resplit, reproof-read and changelogs must be written) but I
> > decided to send these ones for now. The rest will maybe be merged for
> > 2.6.20.

> None of this really looks like -rc3 material.  Why do you think it's
> serious enough to justify late inclusion?

> I'm not particularly fussed about UBD though - if you and Jeff particularly
> want this lot in 2.6.19 then the world won't end.

If Jeff is worried about these patches destabilizing UML you can held them out 
for now (but keep in -mm for 2.6.20), that's absolutely fine for me; however 
there are a few real bug fixes for error paths and IMHO they are safe enough 
to merge.

> "[PATCH 03/11] uml ubd driver: var renames" didn't apply due to
> dummy_device_release not being present, which doesn't inspire confidence.
> What tree are you patching?
It's just git HEAD, but earlier little patches cause that conflict. 
I am sure that the obvious fixup is correct.

I just gave a look to that hunk in the addition log and it looks ok.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
