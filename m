Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269477AbUJSQKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269477AbUJSQKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269473AbUJSQKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:10:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:48528 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269477AbUJSQFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:05:41 -0400
Date: Tue, 19 Oct 2004 09:05:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 BK build broken
In-Reply-To: <20041019090019.GA6020@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.58.0410190904050.2317@ppc970.osdl.org>
References: <20041019021719.GA22924@merlin.emma.line.org> <41747CA6.7030400@pobox.com>
 <41748ADE.70403@pobox.com> <Pine.LNX.4.58.0410182208020.2287@ppc970.osdl.org>
 <20041019090019.GA6020@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Oct 2004, Matthias Andree wrote:
> 
> I'd tried SuSE's gcc-3.3.3-41 (as shipped with SuSE Linux 9.1 Pro),
> pristine gcc 3.3.4, pristine gcc 3.4.2, each of the three failed - and I
> therefore claim "having really up-to-date compilers" for my system.

Yes. My problem was that ppc64 doesn't use "-traditional", and the x86
machine I thought I had tried it on had plain 2.6.9, not my latest tree ;)

Anyway. It should all be fixed in current BK.

		Linus
