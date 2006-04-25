Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWDYC6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWDYC6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWDYC6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:58:39 -0400
Received: from nproxy.gmail.com ([64.233.182.189]:20913 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750736AbWDYC6i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:58:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XZ8z+8dE267mf2nFS/5TGgfpBDk5um5O8zy2dUfUG3ha2Yhbau4lCZI2qWiY+HlyNYcUYbnqG0AoyilGXoolhQ/kkbZGsacG3rFfj5IBgj+39kGgt+xL4i2lJ84eiWp5DsqDHw0vXpq1Ohi6TCBxcssiewriYawFAfPbdvIsrh8=
Message-ID: <9f7850090604241958r55c17c48nb723f22c35253129@mail.gmail.com>
Date: Mon, 24 Apr 2006 19:58:37 -0700
From: "marty fouts" <mf.danger@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: C++ pushback
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0604242107310.25554@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	 <mj+md-20060424.201044.18351.atrey@ucw.cz>
	 <444D44F2.8090300@wolfmountaingroup.com>
	 <1145915533.1635.60.camel@localhost.localdomain>
	 <20060425001617.0a536488@werewolf.auna.net>
	 <Pine.LNX.4.61.0604242107310.25554@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:

> It is possible to compromise a bit and use a slightly higher-level
> procedural language called C. One loses control of everything with
> any other language. Note that before C was invented, all operating
> system code was written in assembly.

Even if by "operating system" you mean kernel,  this turns out not to
be true. Operating systems written in other 'moderate-level' languages
such as Fortran predate C.  (Once upon a time, a company called Pr1me
had an OS called PrimeOS, written in Fortran.)

My all time favorite OS, RSTS/E, was largely written in a Dec variant
of BASIC, called BASIC-PLUS.

High level languages  have been invented just for writing OSes (BLISS)
and OSes have been successfully written in a LISP,  PL/1, and even
C++. The last OS I worked on was almost entirely in C++ and worked ok.

What you don't want to do is add a new language to a system that was
largely written in another language. It's tempting to add C++ to a
large C system because C and C++ are similar, but it's almost always a
disaster, because you organize large systems much differently if you
design them for C++.
