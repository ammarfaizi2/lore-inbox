Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTHGPnC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTHGPmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:42:54 -0400
Received: from web40606.mail.yahoo.com ([66.218.78.143]:20247 "HELO
	web40606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263990AbTHGPlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:41:37 -0400
Message-ID: <20030807154133.54615.qmail@web40606.mail.yahoo.com>
Date: Thu, 7 Aug 2003 16:41:33 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tigran@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1060267992.3168.70.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Looking at it you can do it in initrd fine, or you
> can do it as the first thing you do once the real
> root fs is mounted from init's scripts
> (/etc/rc.sysinit normally)

I'm doing the latter right already. The problem is
that even using ext3, I'm occasionally fscking the
root partition with dodgy CPUs after a lock-up.
Hopefully, initrd will allow me to load the microcode
earlier in the boot sequence.

Cheers,
Chris



________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/
