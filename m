Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVDRPGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVDRPGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVDRPGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:06:20 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:6528 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262095AbVDRPGM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:06:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bsbv5zeody9XKMxyTuQywV4C/3HOVL+Rxv/MjJQ67IWtmH58faHWccoBR6AwGg5gmGoQhTqV0ItmT/SRah4Lvkgs4/e4ylpyghVm6yGtNmzb9DpkW7+aHKUk7AxPdl4AfgELSx9yvarKdq6NGrM7Dlo+FFPkWAaaf3tU5v+RSNQ=
Message-ID: <6533c1c9050418080639e41fb@mail.gmail.com>
Date: Mon, 18 Apr 2005 11:06:11 -0400
From: Igor Shmukler <igor.shmukler@gmail.com>
Reply-To: Igor Shmukler <igor.shmukler@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: intercepting syscalls
Cc: Rik van Riel <riel@redhat.com>, Daniel Souza <thehazard@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1113836378.6274.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
	 <e1e1d5f40504151251617def40@mail.gmail.com>
	 <6533c1c905041512594bb7abb4@mail.gmail.com>
	 <Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>
	 <6533c1c905041807487a872025@mail.gmail.com>
	 <1113836378.6274.69.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Intercepting system call table is an elegant way to solve many
> > problems.
> 
> I think I want to take offence to this. It's the worst possible way to
> solve many problems, especially since almost everyone who did this to
> get anything done until today got it wrong.
> 
> It's about locking. Portability. Stability
> 
> but also about doing things at the right layer. The syscall layer is
> almost NEVER the right layer.
> 
> Can you explain exactly what you are trying to do (it's not a secret I
> assume, kernel modules are GPL and open source after all, esp such
> invasive ones) and I'll try to tell you why it's wrong to do it at the
> syscall intercept layer... deal ?

now, when I need someone to tell I do something wrong, I know where to go :)
