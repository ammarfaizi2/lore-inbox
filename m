Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTKZCTT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 21:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTKZCTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 21:19:19 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:65414 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263902AbTKZCRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 21:17:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 25 Nov 2003 18:17:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: jt@hpl.hp.com
cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
In-Reply-To: <20031126015936.GB14745@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0311251809160.1996-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Jean Tourrilhes wrote:

> 	I believe your issue is unrelated to mine. You seem to have a
> problem with interrupt sharing. You may want to try the Pcmcia mailing
> list or talk to David.

With that patch my card works 100%, while w/out it gets an interrupt at 
boot about once every ten. Now that the SiS IRQ routing has been fixed, 
that is the only patch required to have my laptop to work correctly. Yes, 
it is unrelated to your issue ;)



- Davide


