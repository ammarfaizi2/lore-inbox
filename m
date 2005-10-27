Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVJ0PzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVJ0PzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVJ0PzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:55:07 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:50707 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751117AbVJ0PzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:55:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=NjmogYkew3mZcD11MFYLlfYjIjGXfWr2Qtn9CI1so4l5E5WO5Z+vM5yRiE4yGbwSaCC8cWcKSbe/APeEAbr1pvp04VBoINkQRmRN6eGLyEzhVcBtkiJ6IpKMQauSiol3n4r1EErhbm5NnogIIs2D0CxpBlcBJVptv/gHVmsSHY4=
Subject: Re: 2.6.14-rc5: X spinning in the kernel [ Was: 2.6.14-rc5 GPF in
	radeon_cp_init_ring_buffer()]
From: Badari Pulavarty <pbadari@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510270843100.4664@g5.osdl.org>
References: <Pine.LNX.4.58.0510261103510.24177@skynet>
	 <82b32ed40510262111m2e3b749yca4f78982e879e5e@mail.gmail.com>
	 <1130426711.23729.61.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0510270843100.4664@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 08:54:29 -0700
Message-Id: <1130428469.23729.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 08:45 -0700, Linus Torvalds wrote:
> 
> On Thu, 27 Oct 2005, Badari Pulavarty wrote:
> > 
> > sysrq-t shows nothing :(
> 
> Use sysrq-p to show register state.
> 
> On SMP, you may need to press it several times, to get the right CPU. And 
> if you _never_ get the right CPU, that's likely an indication that it 
> disabled interrupts, or your platform just sends all keyboard interrupts 
> to the same CPU (try to see what happens with interrupt balancing).
> 
> 		Linus

I tried that earlier, it never showed anything useful. 
(2-proc EM64T machine).

SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
SysRq : Show Regs
...

Thanks,
Badari

