Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWGMIVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWGMIVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGMIVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:21:31 -0400
Received: from web25222.mail.ukl.yahoo.com ([217.146.176.208]:28776 "HELO
	web25222.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932424AbWGMIVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:21:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=PEVh6u+xkU+DFpgdMq0CwDWe5a4DDqr1N/yfa6cfIk4KRc2AWu9CxlxNbH8GAbbEMhV7Z3w4mpqh9l/YDqi5+ZwlJBpMZDiHuRMWuNi45z9kuhN4x6fnPVKoRItFliorPbagEZ01G796JQHs/qzrxn+tIRpKoklrrAAAi6t4akA=  ;
Message-ID: <20060713082129.95046.qmail@web25222.mail.ukl.yahoo.com>
Date: Thu, 13 Jul 2006 10:21:29 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 4/5] UML - Reenable SysRq support
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <44B5659E.5070000@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> ha scritto: 

> Why not:
> 
> config MAGIC_SYSRQ
> 	bool
> 	prompt "Magic SysRq key"
> 	depends on !UML || MCONSOLE
> 	default y if UML
> 
> 	-hpa

Because it has always been elsewhere in Kconfig (near MCONSOLE) for a
meaningful reason (it is used through mconsole) and nobody has
decided to move it.

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
