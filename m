Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261946AbSJZIHC>; Sat, 26 Oct 2002 04:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSJZIHC>; Sat, 26 Oct 2002 04:07:02 -0400
Received: from users.linvision.com ([62.58.92.114]:8340 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S261946AbSJZIHB>; Sat, 26 Oct 2002 04:07:01 -0400
Date: Sat, 26 Oct 2002 10:13:10 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Amol Kumar Lad <amolk@ishoni.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: running 2.4.2 kernel under 4MB Ram
Message-ID: <20021026101310.A16359@bitwizard.nl>
References: <1035281203.31873.34.camel@irongate.swansea.linux.org.uk> <1035333109.2200.2.camel@amol.in.ishoni.com> <1035301164.31917.78.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035301164.31917.78.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 04:39:24PM +0100, Alan Cox wrote:
> On Wed, 2002-10-23 at 01:31, Amol Kumar Lad wrote:
> > It means that I _cannot_ run 2.4.2 on a 4MB box. 
> > Actually my embedded system already has 2.4.2 running on a 16Mb. I was
> > looking for a way to run it in 4Mb. 
> > So Is upgrade to 2.4.19 the only option ??
> 
> You should move to a later kernel anyway 2.4.2 has a lot of bugs
> including some security ones.

If the "embedded system" just brews his coffee, then there are not
many security issues he cares about. It gets the job done. 

Amol, Just add a "mem=4M" to the kernel commandline and see what 
happens. It depends a lot on what and how many applications you run
on that system. 

But still, Alan is right. You might run into odd problems that are
simply fixed if you upgrade. (My workstation was "pretty good" at 
staying up under 2.4.2 (about a month at a time), and I didn't want 
to upgrade, for fear of it getting worse. I upgraded and now get
much better uptimes (until my colleague types "reboot -n -f" into 
the wrong window)). 

		Roger.	

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
