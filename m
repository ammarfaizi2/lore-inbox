Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbTD3M3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTD3M3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:29:33 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:59398 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S262150AbTD3M3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:29:33 -0400
Message-Id: <200304301202.h3UC2eu23935@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Bug in linux kernel when playing DVDs.
Date: Wed, 30 Apr 2003 15:10:16 +0300
X-Mailer: KMail [version 1.3.2]
Cc: James@superbug.demon.co.uk, linux-kernel@vger.kernel.org
References: <3EABB532.5000101@superbug.demon.co.uk> <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua> <3EAE220D.4010602@cyberone.com.au>
In-Reply-To: <3EAE220D.4010602@cyberone.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 April 2003 09:56, Nick Piggin wrote:
> >>At some point during the playing there is an error on the DVD. But
> >>currently this error is not handled correctly by the linux kernel.
> >>This puts the kernel into an uncertain state, causing the kernel to
> >>take 100% CPU and fail all future read requests.
>
> [snip]
>
> >Apart of making max retry # settable by the user, I don't see how
> >this can be made better.
>
> Having the kernel not use 100% CPU?

I suspect IDE error recovery path was never audited for that
--
vda
