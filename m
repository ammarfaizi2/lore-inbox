Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966723AbWKOJuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966723AbWKOJuJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 04:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966725AbWKOJuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 04:50:09 -0500
Received: from main.gmane.org ([80.91.229.2]:52179 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S966723AbWKOJuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 04:50:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Subject: Re: [ARM - Xscale Pxa 255] dlopen()s segfault at first runt; Subsequent runs succeeds.
Date: Wed, 15 Nov 2006 10:11:25 +0100
Message-ID: <87k61xcbwi.fsf@fc5.bigo.ensc.de>
References: <455A40DF.3040903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54b4dcc3.dip.t-dialin.net
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
Cancel-Lock: sha1:6A8SziTzPXFWyifnIGA2EpwKmxI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Pereira Nunes <alexandre.nunes@gmail.com> writes:

> With Linux 2.6.18 we're experiencing the symptoms describe above; On
> the first attempt to load a binary which in turns explicitly loads a
> DSO, there's a crash. Subsequent attempts succeeds.

Might be the issue described at

     http://article.gmane.org/gmane.linux.ports.arm.kernel/28068
     http://article.gmane.org/gmane.linux.kernel/463291

Temporary solution was to revert a zlib related patch.



Enrico

