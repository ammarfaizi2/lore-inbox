Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbTDNTbn (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTDNTbn (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:31:43 -0400
Received: from [195.60.21.2] ([195.60.21.2]:52167 "EHLO pluto.fastfreenet.com")
	by vger.kernel.org with ESMTP id S263696AbTDNTbm (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:31:42 -0400
Message-ID: <004301c302bd$ed548680$fe64a8c0@webserver>
From: "Bryan Shumsky" <bzs@via.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com>
Subject: Re: Memory mapped files question
Date: Mon, 14 Apr 2003 12:42:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.  Thanks for all your responses.  Our confusion is that in Unix
environments, when we modify memory in memory-mapped files the underlying
system flusher manages to flush the files for us before the files are
munmap'ed or msysnc'ed.

Rewriting all of our code to manually handle the flushing is a MAJOR
undertaking, so I was hoping there might be some sneaky solution you could
come up with.  Any ideas?

Thanks again,

-- Bryan Shumsky
Director of Engineering
Via Systems, Inc.

----- Original Message -----
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Bryan Shumsky'" <bzs@via.com>; <linux-kernel@vger.kernel.org>
Sent: Monday, April 14, 2003 12:31 PM
Subject: RE: Memory mapped files question


>
> > From: Bryan Shumsky [mailto:bzs@via.com]
>
> > Hi, everyone.  I'm running into a problem that I hope someone else has
> seen,
> > and maybe can help solve.  We're using the mmap system function for
memory
> > mapped files, but our updates never get flushed until we munmap or
msysnc.
>
> I thought that was the way it was supposed to work.
>
> Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
> (and my fault)
>
>


