Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSI0IZU>; Fri, 27 Sep 2002 04:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbSI0IZU>; Fri, 27 Sep 2002 04:25:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58892 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261664AbSI0IZU>; Fri, 27 Sep 2002 04:25:20 -0400
Message-Id: <200209270826.g8R8Q1p08145@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Does kernel use system stdarg.h?
Date: Fri, 27 Sep 2002 11:20:15 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200209270804.g8R84cp08026@Port.imtp.ilyichevsk.odessa.ua> <20020927092647.A7485@flint.arm.linux.org.uk>
In-Reply-To: <20020927092647.A7485@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 September 2002 06:26, Russell King wrote:
> > There is no stdarg.h in kernel tree, should it be there?
> > For now I just copied GCC one into linux/include...
>
> It must be the GCC one.  If your GCC isn't finding it, then you've got a
> broken GCC installation; "-iwithprefix include" tells GCC to look in its
> private include directory for such things.
>
> You could try adding -v to CFLAGS to see where it is searching for
> includes.

Oh, I thought we don't depend on any system/GCC headers. :-(
--
vda 
