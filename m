Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269043AbUI2VYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269043AbUI2VYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUI2VYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:24:50 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:55066 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269043AbUI2VYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:24:09 -0400
Message-ID: <35fb2e5904092914243694baa4@mail.gmail.com>
Date: Wed, 29 Sep 2004 22:24:08 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Tim Bird <tim.bird@am.sony.com>
Subject: Re: Is there a problem in timeval_to_jiffies?
Cc: Henry Margies <henry.margies@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <415B2178.7060907@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040909154828.5972376a.henry.margies@gmx.de>
	 <20040912163319.6e55fbe6.henry.margies@gmx.de>
	 <20040915203039.369bb866.rddunlap@osdl.org>
	 <414962DF.5080209@mvista.com>
	 <20040916200203.6259e113.henry.margies@gmx.de>
	 <4149F56E.50406@mvista.com>
	 <20040917115502.33831479.henry.margies@gmx.de>
	 <415B2178.7060907@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004 13:56:24 -0700, Tim Bird <tim.bird@am.sony.com> wrote:

Apologies for butting in.

> If you are rescheduling one-shot timers immediately
> after they fire, you should 'undershoot' on the time
> interval, to hit the tick boundary you want, based
> on the jiffy resolution of your platform.

Can I just do a ^^^^ here - this is what the original poster really
needs to know to solve the immediate problem of overshooting - then a
good book can help with the rest.

Jon.
