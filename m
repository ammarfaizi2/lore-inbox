Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSFDTzI>; Tue, 4 Jun 2002 15:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSFDTy3>; Tue, 4 Jun 2002 15:54:29 -0400
Received: from codepoet.org ([166.70.14.212]:23708 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S316675AbSFDTyV>;
	Tue, 4 Jun 2002 15:54:21 -0400
Date: Tue, 4 Jun 2002 13:54:03 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Ian Soboroff <ian.soboroff@nist.gov>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch for broken Dell C600 and I5000
Message-ID: <20020604195403.GA7565@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Ian Soboroff <ian.soboroff@nist.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <20020604010756.A32059@devserv.devel.redhat.com> <mailman.1023209101.6092.linux-kernel2news@redhat.com> <200206041752.g54HqlW04012@devserv.devel.redhat.com> <20020604181801.GA6419@codepoet.org> <1023222597.3439.189.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 04, 2002 at 09:29:57PM +0100, Alan Cox wrote:
> On Tue, 2002-06-04 at 19:18, Erik Andersen wrote:
> > On a related note...  I recently updated to Bios A20 and I find
> > the fan stays on after resuming...  Also, in order for resume to
> > complete sucessfully I find I need to never start X with dri so
> > that agp support and the r128 module are not loaded.  If they
> > load then the laptop hangs when doing a resume.  Known problems?
> 
> Yes - it appears that some of the register state needs to be restored
> into the AGP registers when we resume. We have hooks for that but
> someone needs to sit down and either try rerunning the init code for the
> AGP on a resume or sit with a serial console working out what bits need
> fixup

serial console?  We the system seems to be dead dead dead when
resuming, so I'm not sure how that would help.  Regardless, if
you can tell me how to hunt for the cause of the problem I'll
gladly work at fixing it, 

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
