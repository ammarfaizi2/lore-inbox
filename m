Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbULUTEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbULUTEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULUTEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:04:38 -0500
Received: from web52605.mail.yahoo.com ([206.190.39.143]:44928 "HELO
	web52605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261342AbULUTDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:03:46 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=menDgf/Ga8bImc/JthaTLZYPpYlJnYbc2+4Mc/PvHW4a+jCiEn1dKzz9zHz6Q8Y7pqFrNHihtdeJ1NiJ9AnQj4OovpdFEaWBqGHZivg9OhUOdxhSadUAgI1e4AyKNoif8qiZPg9iH0cwwFUDNox7PJZEJuEn0oMvk8FzF1h1Nc4=  ;
Message-ID: <20041221190339.24215.qmail@web52605.mail.yahoo.com>
Date: Tue, 21 Dec 2004 11:03:39 -0800 (PST)
From: jesse <jessezx@yahoo.com>
Subject: Re: Gurus, a silly question for preemptive behavior
To: Paulo Marques <pmarques@grupopie.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
In-Reply-To: <41C86F2A.7020409@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo:
 
   I already said in the messsage that my user space
application has a low nice priority, i set it to 10.
since my application has low priority compared to
other user space applications, it is supposed to be
interrupted. but it is not.

 regards!

jesse


--- Paulo Marques <pmarques@grupopie.com> wrote:

> jesse wrote:
> > Con:
> > 
> >    thank you for your prompt reply in the holiday
> > season. 
> > 
> >    My point is: Even kernel 2.4 is not 
> > preemptive, the latence should be very
> > minimal.(<300ms)
> > why user space application with low nice priority
> > can't be effectively interrupted and holds the CPU
> > resource since all user space application is
> > preemptive?
> 
> If your process has got work to do and has a higher
> priority than other 
> processes, it gets to run. If you don't want this
> behavior, don't give 
> it such a high priority.
> 
> If you want low latency to do some quick high
> priority task, just do it 
> quickly and relinquish the processor, instead of
> hogging it.
> 
> What are you trying to accomplish, anyway?
> 
> -- 
> Paulo Marques - www.grupopie.com
> 
> "A journey of a thousand miles begins with a single
> step."
> Lao-tzu, The Way of Lao-tzu
> 

