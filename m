Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbTBPUQU>; Sun, 16 Feb 2003 15:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTBPUQU>; Sun, 16 Feb 2003 15:16:20 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:14032 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267434AbTBPUQR>; Sun, 16 Feb 2003 15:16:17 -0500
From: "Alvaro Barbosa G." <alvaro.barbosa-g@ntlworld.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: > > make: *** No rule to make target `2'.  Stop. when make bzImage
Date: Sun, 16 Feb 2003 20:26:10 +0000
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200302161939.21889.alvaro.barbosa-g@ntlworld.com> <20030216200036.GA26590@mars.ravnborg.org>
In-Reply-To: <20030216200036.GA26590@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302162026.10621.alvaro.barbosa-g@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

You are completely right, that was pretty silly of me.....!
That make also sence because i couldn`t find any errors in bz_err.
My excuse is that i got this file where  i copy and past the commands then 
start doing something else....

Thanks again,
alvaro

> > Sorry for the lack of info:
> >
> > Errors happen during:
> > make bzImage
> > will add the error file bzI_err
> > the architecture is for i686
> > this happen also with phoebe kernel-2.4.20-2.48, i had this problem a few
> > days ago, so i upgraded gcc, cpp, glibc, rpm to the latest rawhide rpms
> > 15.2.03, but get the same error 'make No rule to make target '2''
>
> You did not provide the exact command you are using..
> The attached log of the output looks OK. And I did not find the
> offending error.
>
> I suspect that the syntax you use to divert output to a file is wrong,
> because the above error happens when you execute:
> make 2
>
> Try to doublecheck how you invoke make, and check any relevant environment
> variables.
>
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

