Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264953AbRFZOLD>; Tue, 26 Jun 2001 10:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264957AbRFZOKx>; Tue, 26 Jun 2001 10:10:53 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:4619 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S264953AbRFZOKh>;
	Tue, 26 Jun 2001 10:10:37 -0400
Date: Tue, 26 Jun 2001 16:10:49 +0200
From: Florian Lohoff <flo@rfc822.org>
To: ext3-users@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in iput
Message-ID: <20010626161049.C1425@paradigm.rfc822.org>
In-Reply-To: <20010625201612.A701@paradigm.rfc822.org> <20010625194213.J18856@redhat.com> <20010626110933.R1503@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010626110933.R1503@niksula.cs.hut.fi>; from vherva@mail.niksula.cs.hut.fi on Tue, Jun 26, 2001 at 11:09:33AM +0300
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 11:09:33AM +0300, Ville Herva wrote:
> Well, I for one use the 2.2 ide patches extensively (on almost all of my
> machines, including a heavy-duty backup server), and haven't seen any
> problems whatsoever. I see _much_ more problems with scsi (aic7xxx), for
> example.

I have been using the udma ide patches for a long time and as long as
you stay away from known buggy drives controllers you are fine.

BTW: The machine i reported the bug for is mostly running on SCSI - Only
/var/tmp is an large IDE drive.
 
> I don't mean to say the ide patches are 100% bug free, but I wouldn't
> consider them as the prime suspect for an oops that happened elsewhere
> either. It could be hw or any other part of kernel just as well... What
> about memtest86?

I'll try 

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

