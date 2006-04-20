Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWDTWSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWDTWSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWDTWSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:18:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:23194 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932079AbWDTWST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:18:19 -0400
X-Authenticated: #4399952
Date: Fri, 21 Apr 2006 00:18:15 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Michael Monnerie <michael.monnerie@it-management.at>,
       linux-kernel@vger.kernel.org
Subject: Re: rtc: lost some interrupts at 256Hz
Message-ID: <20060421001815.1256624f@mango.fruits>
In-Reply-To: <1145566983.5412.31.camel@mindpipe>
References: <200604202237.34134@zmi.at>
	<1145566983.5412.31.camel@mindpipe>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006 17:03:02 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> Changing the preemption model to voluntary or full preemption could
> certainly help.  What app is using the RTC, mplayer?

I wonder what the "lost ticks" message really means. That the tick
wasn't consumed by a read on the device file? If so, setting niceness or
rt prio for the consuming task might help. 

Or does it mean that the kernel failed in some way keeping up with the
rtc?

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
