Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317666AbSGUIop>; Sun, 21 Jul 2002 04:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317667AbSGUIoo>; Sun, 21 Jul 2002 04:44:44 -0400
Received: from ns.suse.de ([213.95.15.193]:47620 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317666AbSGUIoo>;
	Sun, 21 Jul 2002 04:44:44 -0400
Date: Sun, 21 Jul 2002 10:47:43 +0200
From: Andi Kleen <ak@suse.de>
To: Oliver Neukum <oliver@neukum.name>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020721104743.A31913@wotan.suse.de>
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com.suse.lists.linux.kernel> <1027199147.16819.39.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <p731y9xva8m.fsf@oldwotan.suse.de> <200207211033.59266.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207211033.59266.oliver@neukum.name>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 10:33:59AM +0200, Oliver Neukum wrote:
> Am Sonntag, 21. Juli 2002 08:57 schrieb Andi Kleen:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > > o EVMS (Enterprise Volume Management System)      (EVMS team)
> > >
> > > or LVM2, which already appears to be scrubbed down and clean
> >
> > Is there any reason why not both can go in? As far as I know neither
> > of them needs much of core changes, they are more like independent
> > "drivers" of the generic block layer stacking interface. There are
> > already multiple drivers of this - LVM and the various MD personalities.
> 
> The interfaces to filesystems for things like online resizing.
> If these are not compatible and stay compatible, you cause fs
> developers a lot of pain.

Both LVM and EVMS do file system resizing in user space and by calling
some file system specific modules. So the filesystem is in control.
No issue.

-Andi
