Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316423AbSE3HHa>; Thu, 30 May 2002 03:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSE3HH3>; Thu, 30 May 2002 03:07:29 -0400
Received: from zok.SGI.COM ([204.94.215.101]:14506 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316423AbSE3HH2>;
	Thu, 30 May 2002 03:07:28 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Decoding of addreses in kernel logs 
In-Reply-To: Your message of "Thu, 30 May 2002 10:57:50 +0400."
             <6134254DE87BD411908B00A0C99B044F037F72F5@mowd019a.mow.siemens.ru> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 May 2002 17:07:01 +1000
Message-ID: <28024.1022742421@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002 10:57:50 +0400, 
Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru> wrote:
>Are there any cases except oopses when decoding of addresses in kernel logs
>is needed? The reason is I'd like to switch from klogd+syslogd to other
>logging system and I was adviced to forget klogd and just get logs from
>/proc/kmsg and decode them with ksymoops. While I have no problem with it
>actually, my concern is - is it possible that some information in kernel
>logs can be decoded by klogd but not by ksymoops?

It is the other way around.  ksymoops decodes far more than klogd does.
ksymoops has been continually extended as new diagnostics are added to
the kernel, klogd has not.

