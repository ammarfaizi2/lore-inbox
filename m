Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314024AbSDQBze>; Tue, 16 Apr 2002 21:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314025AbSDQBzd>; Tue, 16 Apr 2002 21:55:33 -0400
Received: from smtp.comcast.net ([24.153.64.2]:491 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S314024AbSDQBzc>;
	Tue, 16 Apr 2002 21:55:32 -0400
Date: Tue, 16 Apr 2002 20:55:25 -0500
From: Josh McKinney <forming@comcast.net>
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
In-Reply-To: <200204161843.g3GIhSX26862@Port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20020417015525.GA3118@cy599856-a>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.4.19-pre6 i686
X-Processor: Athlon XP 2000+
X-Uptime: 20:49:56 up  3:09,  2 users,  load average: 1.00, 0.99, 0.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Tue, Apr 16, 2002 at 09:45:43PM -0200, Denis Vlasenko wrote:
> >
> > I get (when FSCK):
> >
> > spurious 8259A IRQ7
> 
> cat /proc/interrupts, is ther lots of ERR: interrupts?
> 

I also get the spurious 8259A messages upon booting my Soyo Dragon+ board, KT266A chipset.
Here is the output of /proc/interrupts:

         CPU0
  0:    1146449          XT-PIC  timer
  1:       1258          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 10:      10584          XT-PIC  eth0
 11:          0          XT-PIC  es1370
 12:         20          XT-PIC  PS/2 Mouse
 14:         17          XT-PIC  ide0
 15:      15193          XT-PIC  ide1
NMI:          0
LOC:    1146346
ERR:         78
MIS:          0

I am just curious as to what this means, I haven't seen any real problems with the board,
except for everything wanting to go to IRQ 11, but that isn't a kernel issue.

Josh

