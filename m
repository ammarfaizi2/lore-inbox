Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUCPVmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUCPVmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:42:39 -0500
Received: from mail.tpgi.com.au ([203.12.160.61]:21219 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261729AbUCPVmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:42:35 -0500
Subject: Re: Remove pmdisk from kernel
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20040316101715.GA2175@elf.ucw.cz>
References: <20040315195440.GA1312@elf.ucw.cz>
	 <20040315125357.3330c8c4.akpm@osdl.org> <20040315205752.GG258@elf.ucw.cz>
	 <20040315132146.24f935c2.akpm@osdl.org>
	 <1079379519.5350.20.camel@calvin.wpcb.org.au>
	 <20040316005618.GB1883@elf.ucw.cz>
	 <1079393256.2043.5.camel@calvin.wpcb.org.au>
	 <20040316101715.GA2175@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1079465824.3403.23.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Wed, 17 Mar 2004 08:37:04 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-03-16 at 23:17, Pavel Machek wrote:
> Hmm, you are right that with dead nfs server, kill -SIGSTOP will fail
> on ls, and similary current refrigerator will fail. I think we can
> live with that.
> 
> I agree that two-stage suspend is probably neccessary (userland first,
> kernel than); but that should be possible without that big changes,
> right?

It would certainly be simple to change to a two stage freeze. I don't
think I've tried that, so I'll cut the code and give it a try.

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

