Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261766AbSJVUGt>; Tue, 22 Oct 2002 16:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264813AbSJVUGt>; Tue, 22 Oct 2002 16:06:49 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:63674 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261766AbSJVUGr>; Tue, 22 Oct 2002 16:06:47 -0400
Subject: Re: I386 cli
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Grothe <dave@gcom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20021022145759.02861ec8@localhost>
References: <5.1.0.14.2.20021022145759.02861ec8@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 21:29:11 +0100
Message-Id: <1035318551.31873.143.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 21:01, David Grothe wrote:
> In 2.5.41every architecture except Intel 386 has a "#define cli 
> <something>" in its asm-arch/system.h file.  Is there supposed to be such a 
> define in asm-i386/system.h?  If not, where does the "official" definition 
> of cli() live for Intel?  Or what is the include file that one needs to 
> pick it up?  I can't find it.

The old style cli/global irq lock stuff has been exterminated. There is
no direct equivalent any more. 

