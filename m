Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSKYKGV>; Mon, 25 Nov 2002 05:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSKYKGV>; Mon, 25 Nov 2002 05:06:21 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9483 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262806AbSKYKGU>; Mon, 25 Nov 2002 05:06:20 -0500
Message-Id: <200211251004.gAPA4rp09456@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Willy Tarreau <willy@w.ods.org>, David Zaffiro <davzaffiro@netscape.net>
Subject: Re: Compiling x86 with and without frame pointer
Date: Mon, 25 Nov 2002 12:55:30 -0200
X-Mailer: KMail [version 1.3.2]
Cc: willy@w.ods.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <19005.1037854033@kao2.melbourne.sgi.com> <3DE1E384.8000801@netscape.net> <20021125085229.GA15592@alpha.home.local>
In-Reply-To: <20021125085229.GA15592@alpha.home.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 November 2002 06:52, Willy Tarreau wrote:
> > Anyway it makes me wonder, whether kernelcompilation shouldn't be
> > configurable between a "optimize for (compressed image) size" and a
> > "optimize for speed" option... I'd go for speed... (and always
> > omitting frame-pointers doesn't seem to as fast as omitting them
> > only in leaf functions).
>
> hehe :-)
> I've put this in my kernels for about 2 years now. You can also
> reduce the image size with -malign-jumps=0
> -mpreferred-stack-boundary=2 and -mcpu=i386.

Hehe indeed ;)
--
vda
