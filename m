Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261766AbSKCMAH>; Sun, 3 Nov 2002 07:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSKCMAH>; Sun, 3 Nov 2002 07:00:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:15500 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261766AbSKCMAF>; Sun, 3 Nov 2002 07:00:05 -0500
Subject: Re: Oh no, local symbols in discarded section .exit.text _again_ :)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211031139.gA3Bdtp27867@Port.imtp.ilyichevsk.odessa.ua>
References: <200211031139.gA3Bdtp27867@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 12:27:29 +0000
Message-Id: <1036326449.29642.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 16:31, Denis Vlasenko wrote:
> I've got well-known
> 
> drivers/built-in.o(.data+0xa6b4): undefined reference to
> `local symbols in discarded section .exit.text'

Almost certainly the tulip driver

