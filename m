Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbTAYNxm>; Sat, 25 Jan 2003 08:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbTAYNxm>; Sat, 25 Jan 2003 08:53:42 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:5829 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266431AbTAYNxl>;
	Sat, 25 Jan 2003 08:53:41 -0500
Date: Sat, 25 Jan 2003 15:02:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Andrew McGregor <andrew@indranet.co.nz>, Valdis.Kletnieks@vt.edu,
       Mikael Pettersson <mikpe@csd.uu.se>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
Message-ID: <20030125150216.B5744@ucw.cz>
References: <15909.13901.284523.220804@harpo.it.uu.se> <481480000.1042627438@localhost.localdomain> <200301151921.h0FJLvV0009887@turing-police.cc.vt.edu> <3660000.1042685449@localhost.localdomain> <3E26B497.8000301@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E26B497.8000301@oracle.com>; from alessandro.suardi@oracle.com on Thu, Jan 16, 2003 at 02:33:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 02:33:11PM +0100, Alessandro Suardi wrote:
> Andrew McGregor wrote:
> > The i8k will power off with APM but not ACPI, but it won't reboot with 
> > either.
> > 
> > I'm using grub, so it may hit the problem before outputting anything 
> > where lilo may not.
> 
> [Fixed CC: to Vojtech]
> 
> CPx750J powers off with grub/APM
> C640    powers off with grub/ACPI - much earlier than the CPx
> 
> Most likely the same interval of kernel that Valdis mentions. For
>   sure both behave like this in 2.5.58.

Do the symptoms persist when you disable AT keyboard support completely?
(You'll need a different way to control the machine - USB or Ethernet
for the test.)

> > --On Wednesday, January 15, 2003 14:21:57 -0500 Valdis.Kletnieks@vt.edu 
> > wrote:
> > 
> >> On Wed, 15 Jan 2003 23:43:58 +1300, Andrew McGregor said:
> >>
> >>> Possibly related:
> >>>
> >>> Dell Inspiron 8000s won't warm reboot either.  They just freeze with a
> >>> blinking cursor at the point where the bootloader would ordinarily load.
> >>> Have to power off or reset.
> >>>
> >>> Consistent in various versions from 2.5.44 to .55.  Have not tested
> >>> earlier, nor yet later.
> >>
> >>
> >> Dell Latitude C840s will power off.  Oddly enough, it doesn't do it when
> >> LILO itself loads - it does it when LILO starts loading the actual kernel
> >> image.  True from 2.5.46 through 2.5.58.
> 
> --alessandro
> 
>   "And though it don't seem fair, for every smile that plays
>     a tear must fall somewhere"
>         (Bruce Springsteen, "The Price You Pay", live 31/12/1980)

-- 
Vojtech Pavlik
SuSE Labs
