Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265481AbSJXPNO>; Thu, 24 Oct 2002 11:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265482AbSJXPNO>; Thu, 24 Oct 2002 11:13:14 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:60355 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265481AbSJXPNN>; Thu, 24 Oct 2002 11:13:13 -0400
Subject: Re: One for the Security Guru's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ap90p7$djo$1@forge.intermeta.de>
References: <20021023130251.GF25422@rdlg.net>
	<1035460549.8675.50.camel@irongate.swansea.linux.org.uk> 
	<ap90p7$djo$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 16:36:27 +0100
Message-Id: <1035473787.8701.57.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 15:40, Henning P. Schmiedehausen wrote:
> Removing CAP_SYS_RAWIO is nice, but I actually want to remove the code
> from the kernel, not just disabling it (Yes, of course I could try but
> my test box is in pieces ATM...).

Just removing /dev/mem isnt enough. You still need CAP_SYS_RAWIO
revoked. There are many raw i/o accessors it covers

