Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279904AbRKIN4k>; Fri, 9 Nov 2001 08:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279906AbRKIN43>; Fri, 9 Nov 2001 08:56:29 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:2488 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S279904AbRKIN4O>; Fri, 9 Nov 2001 08:56:14 -0500
Message-ID: <3BEBE10F.902395CA@oracle.com>
Date: Fri, 09 Nov 2001 14:58:39 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre1-ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <lkml-frank@unternet.org>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
In-Reply-To: <8A11A922758@vcnet.vc.cvut.cz> <20011108233954.D11523@unternet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:
> 
> On Thu, Nov 08, 2001 at 11:34:38PM +0000, Petr Vandrovec wrote:
> > If you see something different from your box, or from your VMs, tell me.
> > But adding some SCSI adapter is beyond PCI slots of my box. I also
> > assume that you are using released VMware version, build 1455.
> 
> Yeah, using VMware build 1455 on ABit BP-6 with 2 * Celeron 466@466, 768 MB RAM
> (dirt cheap nowadays so why not...), 2 * Maxtor 40GB IDE on BX controller, HPT
> controller not in use, Matrox G400. I've seen the rtc: blah errors, stressed
> the box to its limits with VM's with Linux/WinXP, and every now and then...
> 
> it just freezes... (only when using a Linus kernel, and only when using VMware)
> 
> I'll try 2.4.15pre, maybe it helps...

2.4.14 + VMWare 1455 froze on my laptop the other day, hard hang, no
 keyboard, had to keep poweroff pressed for several seconds to shut
 the box down. Ext3 though minimized quite nicely startup time :)

I can't now try to go much further - I zapped the original NT install
 I didn't perform properly but my PageUp/PageDown keys aren't working
 anymore (hardware bug, sigh) and I can't scroll past the NT EULA as
 it wants PageDown :( Next week I'm getting the keyboard fixed, so I
 will resume testing.

The full installation though in the various attempts I performed went
 through twice whilst I had only 1 freeze.

This is a Dell Latitude CPx750J, 256MB RAM, 20GB IBM disk, Xircom
 RBEM56G100TX network card.

--alessandro

 "we live as we dream alone / to break the spell we mix with the others
  we were not born in isolation / but sometimes it seems that way"
     (R.E.M., live intro to 'World Leader Pretend')
