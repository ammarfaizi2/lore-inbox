Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288089AbSAHPML>; Tue, 8 Jan 2002 10:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288090AbSAHPMB>; Tue, 8 Jan 2002 10:12:01 -0500
Received: from danielle.hinet.hr ([195.29.148.143]:50309 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S288089AbSAHPLw>; Tue, 8 Jan 2002 10:11:52 -0500
Date: Tue, 8 Jan 2002 16:11:37 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: Doug Ledford <dledford@redhat.com>
Cc: Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        Nathan Bryant <nbryant@allegientsystems.com>,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio
Message-ID: <20020108161137.A6747@danielle.hinet.hr>
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at> <3C3A2B5D.8070707@allegientsystems.com> <3C3A301A.2050501@redhat.com> <3C3AA6F9.5090407@redhat.com> <3C3AA9AD.6070203@redhat.com> <3C3AB5AB.2080102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C3AB5AB.2080102@redhat.com>; from dledford@redhat.com on Tue, Jan 08, 2002 at 04:02:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> OK, various clean ups made, and enough of the SiS code included that I think 
> it should work, plus one change to the i810 interrupt handler that will 
> (hopefully) render the other change you made to get_dma_addr and drain_dac 
> unnecessary.  If people could please download and test the new 0.14 version 
> of the driver on my site, I would appreciate it.
> 
> http://people.redhat.com/dledford/i810_audio.c.gz

Hmmm, maybe way too much cleanups !? :)

-->

i810_audio.c: In function `i810_get_dma_addr':
i810_audio.c:658: warning: unused variable `c'
i810_audio.c: In function `__stop_dac':
i810_audio.c:747: `PI_OR' undeclared (first use in this function)
i810_audio.c:747: (Each undeclared identifier is reported only once
i810_audio.c:747: for each function it appears in.)
make[2]: *** [i810_audio.o] Error 1
make[1]: *** [_modsubdir_sound] Error 2
make: *** [_mod_drivers] Error 2


ps
	just got a note from a friend that .13 has tendency to lockup with
	heavy network traffic in the same time, no oops, nothing, ..

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
