Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWDKU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWDKU5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWDKU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:57:13 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:3010 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750989AbWDKU5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:57:13 -0400
Subject: Re: [PATCH -rt] Buggy uart (for 2.6.16)
From: Steven Rostedt <rostedt@goodmis.org>
To: Gunther Mayer <gunther.mayer@gmx.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <443A8D70.3040906@gmx.net>
References: <1144676225.12145.30.camel@localhost.localdomain>
	 <443A8D70.3040906@gmx.net>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 16:57:00 -0400
Message-Id: <1144789020.14313.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 18:53 +0200, Gunther Mayer wrote:

> >
> Can you name the exact 8250 model which is buggy ?
> 

>From the spec:

COM1 und COM2 werden mittels der Ultra IO FDC37C675 implementiert. COM3
und COM4 sind 16C550 oder kompatible.


I'm using COM1 and COM2 so it's the Ultra IO FDC37C675.

-- Steve


