Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbRBASoV>; Thu, 1 Feb 2001 13:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130866AbRBASoL>; Thu, 1 Feb 2001 13:44:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10256 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129261AbRBASoC>; Thu, 1 Feb 2001 13:44:02 -0500
Subject: Re: problem with devfsd compilation
To: hiren_mehta@agilent.com
Date: Thu, 1 Feb 2001 18:45:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188097A@xsj02.sjs.agilent.com> from "hiren_mehta@agilent.com" at Feb 01, 2001 11:37:59 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OOjA-0004qS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to compile devfsd on my system running RedHat linux 7.0
> (kernel 2.2.16-22). I get the error "RTLD_NEXT" undefined. I am not
> sure where this symbol is defined. Is there anything that I am missing 
> on my system. 

Sounds like a missing include in the devfsd code. That comes from
dlfcn.h.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
