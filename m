Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316013AbSEJOlL>; Fri, 10 May 2002 10:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316011AbSEJOlK>; Fri, 10 May 2002 10:41:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52998 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316010AbSEJOlJ>; Fri, 10 May 2002 10:41:09 -0400
Message-Id: <200205101438.g4AEc9X29850@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: DervishD <raul@viadomus.com>
Subject: Re: mmap() doesn't like certain value...
Date: Fri, 10 May 2002 17:41:12 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD983C5.mail1K71EX1NG@viadomus.com> <200205100810.g4A8AaX28554@Port.imtp.ilyichevsk.odessa.ua> <3CDB8740.mailBO1BW5NO@viadomus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 May 2002 06:39, DervishD wrote:
> >        if ((len = PAGE_ALIGN(len)) == 0)
> >                return addr;
>
>     This is the problem.
>
> >        if (len > TASK_SIZE)
> >                return -EINVAL;
>
>     And is corrected just by inverting the two quoted code snips :)

You are right

>     I'll give a try to the inversion, that should work. I have
> written a small stress program for mmap, so in a few hours the patch
> will be ready. Must I post it here or send it directly to Marcello?

Post here and to Marcelo. BTW, is 2.5 affected?
--
vda
