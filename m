Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSKDK6k>; Mon, 4 Nov 2002 05:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264645AbSKDK6k>; Mon, 4 Nov 2002 05:58:40 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61202 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264644AbSKDK6j>; Mon, 4 Nov 2002 05:58:39 -0500
Message-Id: <200211041059.gA4Axvp32035@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Oh no, local symbols in discarded section .exit.text _again_ :)
Date: Mon, 4 Nov 2002 13:51:51 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200211031139.gA3Bdtp27867@Port.imtp.ilyichevsk.odessa.ua> <1036326449.29642.0.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1036326449.29642.0.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 10:27, Alan Cox wrote:
> On Sun, 2002-11-03 at 16:31, Denis Vlasenko wrote:
> > I've got well-known
> >
> > drivers/built-in.o(.data+0xa6b4): undefined reference to
> > `local symbols in discarded section .exit.text'
>
> Almost certainly the tulip driver

Yes.

Finding objects, 862 objects, ignoring 42 module(s)
Finding conglomerates, ignoring 74 conglomerate(s)
Scanning objects
Error: ./drivers/net/tulip/de2104x.o .data refers to 00000074 R_386_32          .exit.text
Done
--
vda
