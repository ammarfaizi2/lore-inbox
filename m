Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270696AbUJUI24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270696AbUJUI24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270686AbUJUI2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:28:51 -0400
Received: from pat.uio.no ([129.240.130.16]:24562 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S270702AbUJUIYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:24:33 -0400
Subject: Re: [PATCH] sunrpc: replace sleep_on_timeout()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041021074245.GB20573@elte.hu>
References: <1098300093.20821.58.camel@thomas>
	 <1098343597.28394.10.camel@lade.trondhjem.org>
	 <20041021074245.GB20573@elte.hu>
Content-Type: text/plain
Date: Thu, 21 Oct 2004 10:24:02 +0200
Message-Id: <1098347042.28394.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 21.10.2004 Klokka 09:42 (+0200) skreiv Ingo Molnar:

> ah, indeed. Do you in principle agree with these sleep_on() =>
> wait_event*() conversions in the NFS code? (as long as they are
> correct). sleep_on() is really becoming an architectural wart these
> days.

Sure. Feel free to fix them up, but carefully please. ;-)

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

