Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWG1SNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWG1SNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161211AbWG1SNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:13:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:10652 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161210AbWG1SNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:13:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MVpZmb8iPncmQmKUUMvhK6oFc+vnVjHxrmYLx6DGmlZ/b7OnMCdGmeJNF0nO798FQUoBNoPwF9AN4Ghjm8MuY5faT+u8RCsmJXyxW2r46OSlU/EQIGVDKANg+HK3bhD+IXwaRM2FB615fBGxBmQmb1OAOE6OjLhCaeY4Mdz1ewk=
Message-ID: <6de39a910607281113hb657981jce19f15806e82104@mail.gmail.com>
Date: Fri, 28 Jul 2006 11:13:48 -0700
From: "Handle X" <xhandle@gmail.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Subject: Re: Can we ignore errors in mcelog if the server is running fine
Cc: "Vikas Kedia" <kedia.vikas@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <44C9CC21.9040609@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.5uWgnVpIOBN4Pb1aWwNzF8P2OA0@ifi.uio.no>
	 <fa.9M8mPetEI5HZ8L2RMGPhKPm3gJA@ifi.uio.no> <44C9CC21.9040609@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [root@turyxsrv ~]# mcelog
> > MCE 0
> > HARDWARE ERROR. This is *NOT* a software problem!
> > Please contact your hardware vendor
> > CPU 1 4 northbridge TSC 89a560bb249
> > ADDR 1dfa49690
> >  Northbridge Chipkill ECC error
> >  Chipkill ECC syndrome = 2021
> >       bit46 = corrected ecc error
> >  bus error 'local node response, request didn't time out
> >      generic read mem transaction
> >      memory access, level generic'
> > STATUS 9410c00020080a13 MCGSTATUS 0
>
> > Repeats whenever I do any kind of operations...
> > How severe is ChipKill errors? Should I consider throwing away CPU 1
> > and get another one.
>
> That sounds to me more like some of the RAM attached to CPU1 is bad..
I took out CPU1. Errors went away. But so is half of the RAM
(accessible only to CPU1)
Okay, I would test with swapping the RAM of CPU0 to CPU1 and test. If
I get messages again, I would change the RAM.

Thanks.
Om.
