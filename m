Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756101AbWKRAjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101AbWKRAjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756113AbWKRAjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:39:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55179 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1756101AbWKRAjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:39:17 -0500
Date: Sat, 18 Nov 2006 01:38:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, rjw@sisk.pl
Subject: Re: [PATCH 9/20] x86_64: 64bit PIC SMP trampoline
Message-ID: <20061118003847.GB9187@elf.ucw.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117224535.GJ15449@in.ibm.com> <20061118002710.GF9188@elf.ucw.cz> <20061118003352.GA4321@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118003352.GA4321@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-11-17 19:33:52, Vivek Goyal wrote:
> On Sat, Nov 18, 2006 at 01:27:10AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > that long mode is supported.  Asking if long mode is implemented is
> > > down right silly but we have traditionally had some of these checks,
> > > and they can't hurt anything.  So when the totally ludicrous happens
> > > we just might handle it correctly.
> > 
> > Well, it is silly, and it is 50 lines of dense assembly. can we get
> > rid of it or get it shared with bootup version?
> > 
> 
> Hi Pavel,
> 
> Last patch in the series (patch 20)  already does that. That patch just
> puts all the assembly at one place which everybody shares. 
> 
> I know it is bad to introduce and delete your own code, but I kept that
> patch as last patch as all the other patches have got fair bit of testing
> in RHEL kernels and I wanted to make sure that if last patch breaks something
> problem can be isolated relatively easily.

Ahha, okay. ACK, then.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
