Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268137AbRHBAhq>; Wed, 1 Aug 2001 20:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268086AbRHBAhg>; Wed, 1 Aug 2001 20:37:36 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:4622 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S268137AbRHBAhY>; Wed, 1 Aug 2001 20:37:24 -0400
Date: Wed, 1 Aug 2001 18:40:32 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Scott Ransom <ransom@cfa.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: 3ware Escalade problems
Message-ID: <20010801184032.A22548@vger.timpanogas.org>
In-Reply-To: <20010801143935.A21157@vger.timpanogas.org> <E15S6Ji-00085T-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15S6Ji-00085T-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 02, 2001 at 01:26:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 01:26:22AM +0100, Alan Cox wrote:
> > I am also using 8 way escalade adapters, and am seeing a host of problems.
> 
> I've seen no problems since the 1.02.00.005 driver. 
> 
> > The first and foremore is that the gendisk head in 2.4.X is not being 
> > initialized properly in the driver.  I have reported these problems to
> 
> The gendisk comes from the scsi midlayer so you want linux-scsi for that

Alan,

Try putting four adapters into a system all at once with 32 drives, and 
you will see all sorts of bugs.  I do not see problems with a single board,
other than gendisk reporting junk.  If it's the scsi layer, then the driver 
must not be calling the sd driver.  I will attempt to get on the phone with
Adam, and get these issues resolved.

Jeff


