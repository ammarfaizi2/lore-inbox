Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWILWoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWILWoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWILWoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:44:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964909AbWILWoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:44:24 -0400
Subject: Re: OT: calling kernel syscall manually
From: David Woodhouse <dwmw2@infradead.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: guest01 <guest01@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <450717A5.90509@cfl.rr.com>
References: <4506A295.6010206@gmail.com>
	 <1158068045.9189.93.camel@hades.cambridge.redhat.com>
	 <450717A5.90509@cfl.rr.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 23:43:39 +0100
Message-Id: <1158101019.18619.113.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 16:25 -0400, Phillip Susi wrote:
> What do you mean you have removed the ability to make system calls 
> directly?  That makes no sense.  Glibc has to be able to make system 
> calls so you can write your own code that does the same thing if you want.

No. If you do the inline assembly (or call the vDSO) yourself of course
it's still possible.

However, the _example_ that the OP gave of this 'third one' was in fact
using the old _syscallX() macros which used to be found in the kernel's
private header files. So I assumed that's what he meant, rather than
open-coding his own inline assembly.

-- 
dwmw2

