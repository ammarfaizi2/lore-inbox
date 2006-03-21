Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWCUXCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWCUXCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWCUXCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:02:54 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21966 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750897AbWCUXCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:02:54 -0500
Subject: Re: Idea: Automatic binary driver compiling system
From: Lee Revell <rlrevell@joe-job.com>
To: Bob Copeland <me@bobcopeland.com>
Cc: Benjamin Bach <benjamin@overtag.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <b6c5339f0603200746k3e817e9bmdc278764fe488a8c@mail.gmail.com>
References: <441AF93C.6040407@overtag.dk>
	 <1142620509.25258.53.camel@mindpipe> <441C213A.3000404@overtag.dk>
	 <1142694655.2889.22.camel@laptopd505.fenrus.org>
	 <441C2CF6.1050607@overtag.dk>
	 <1142698292.2889.26.camel@laptopd505.fenrus.org>
	 <441D36DA.2000701@overtag.dk>
	 <b6c5339f0603190719u6e52ba3cwda15509de3ed947e@mail.gmail.com>
	 <441D82D8.7050106@overtag.dk>
	 <b6c5339f0603200746k3e817e9bmdc278764fe488a8c@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 18:02:50 -0500
Message-Id: <1142982171.4532.183.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 10:46 -0500, Bob Copeland wrote:
> On 3/19/06, Benjamin Bach <benjamin@overtag.dk> wrote:
> > Otherwise I'll probably dig up something. Just needs to be a small
> > kernel-whatever project.
> >
> > Is there someone maintaining a list of non-implemented ideas for kernel
> > features/drivers?
> 
> Although neither of these are easy and you very well might not get
> anything done in three months, a couple of bits of hardware that I
> have for which there are incomplete/no drivers, and where the
> manufacturer refuses to give out specs are:
> 
> - Ricoh MMC/SD controllers.  The project to figure those out is at:
> http://mmc.drzeus.cx/wiki/Controllers/Ricoh/Frontreport
> 
> - 3D for NVidia.  I know many people would take an open but basic 3D
> driver over the fully featured binary one - many people already use
> the 2D 'nv' driver for that reason.  Rudolf Cornelissen has reverse
> engineered various bits of it (though it may apply only to the
> geforce-1 era cards) over here:
> http://web.inter.nl.net/users/be-hold/BeOS/NVdriver/3dnews.html
> 

Lots of people don't even need 3D but have to run nvidia's driver to get
multihead support, it seems this would be much easier than full 3D
implementation.

> You will find it's a whole lot easier to write drivers when you have
> specs though, and the resulting drivers will also be better.  But
> depending on the scope of your project, you could definitely learn
> something either way.
> 
> Another thing that would be a lot easier to accomplish in 3 months
> would be to write a userspace filesystem using FUSE for something that
> isn't ordinarily accessed by filesystems; for example currently you
> can mount remote machines over ssh, cameras that can talk to gphoto,
> tar archives, gmail, etc.

Another easy project if you have old sound cards lying around is to port
some of the old OSS drivers to ALSA (a list was posted on LKML a while
back).  This probably will take from a weekend to a few weeks.

Lee


