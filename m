Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWFVRHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWFVRHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWFVRHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:07:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932575AbWFVRHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:07:44 -0400
Date: Thu, 22 Jun 2006 10:07:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: alan@lxorguk.ukuu.org.uk, penberg@cs.Helsinki.FI, alesan@manoweb.com,
       linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru,
       dtor_core@ameritech.net
Subject: Re: [PATCH] cardbus: revert IO window limit
In-Reply-To: <20060622093606.2b3b1eb7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606221005410.5498@g5.osdl.org>
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
 <20060622001104.9e42fc54.akpm@osdl.org> <1150976158.15275.148.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606220917080.5498@g5.osdl.org> <20060622093606.2b3b1eb7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Andrew Morton wrote:
> 
> OK, thanks.  All we have on Alessio's machine is "freezes at boot if APM is enabled"
> (http://lkml.org/lkml/2006/6/16/33).  Any suggestions as to how to proceed
> with that?

It would be interesting to see the output of "/sbin/lspci -vvx" with a 
working and a non-working kernel (obviously APM has to be disabled for 
this test).

And the full bootup dmesg for both cases (preferably with CONFIG_PCI_DEBUG 
enabled)

Alessio?

		Linus
