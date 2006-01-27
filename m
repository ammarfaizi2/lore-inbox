Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWA0ATW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWA0ATW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWA0ATW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:19:22 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:8325 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964774AbWA0ATV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:19:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VrMrPClwfwm+RvbaaswqANgCUYAjhSUQIT017+0/D8xAQDfR8D3EEq1fT6kKd+sgrE7dayO8qoMnnEjlepmkaOlUN8hponyipdBNiW1VrA9V6pNC6r5bPPkBwYbdvPVYNrT6l5BvTZTwLEC6MXrlOA9dynD0bLP4uwvn/mpvFAA=
Message-ID: <cfb54190601261619w3483a4earf30958139057a759@mail.gmail.com>
Date: Fri, 27 Jan 2006 02:19:20 +0200
From: Hai Zaar <haizaar@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: vesa fb is slow on 2.6.15.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>
	 <43D8E1EE.3040302@gmail.com>
	 <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
	 <43D94764.3040303@gmail.com>
	 <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/06, Hai Zaar <haizaar@gmail.com> wrote:
> >
> > You need both vga= and video=vesafb
> Thanks a lot - it did the trick - the speed is back!
BTW, if I use 'ywrap' instead of 'ypan' its even a bit faster: 'cat
/usr/share/man/man1/bash.1'  on tty1 take 11 seconds with ywrap,
against 12 seconds with ypan.

>
> But anyway, do you have a clue why do I still get this error?
> PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:40:00.0
> I've several workstations with _exactly_ the same hardware. I've tried
> two of them - both give the error with 2.6.15.1 (and no errors with
> 2.6.11.12).
> >
> > Tony
> >
>
>
> --
> Zaar
>


--
Zaar
