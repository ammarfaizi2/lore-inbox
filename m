Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268377AbRHBAzr>; Wed, 1 Aug 2001 20:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268331AbRHBAzh>; Wed, 1 Aug 2001 20:55:37 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:8462 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S268358AbRHBAza>; Wed, 1 Aug 2001 20:55:30 -0400
Date: Wed, 1 Aug 2001 18:58:36 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Scott Ransom <ransom@cfa.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: 3ware Escalade problems
Message-ID: <20010801185836.B22548@vger.timpanogas.org>
In-Reply-To: <20010801184032.A22548@vger.timpanogas.org> <E15S6Xn-00088F-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15S6Xn-00088F-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 02, 2001 at 01:40:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 01:40:55AM +0100, Alan Cox wrote:
> > Try putting four adapters into a system all at once with 32 drives, and 
> > you will see all sorts of bugs.  I do not see problems with a single board,
> > other than gendisk reporting junk.  If it's the scsi layer, then the driver 
> > must not be calling the sd driver.  I will attempt to get on the phone with
> > Adam, and get these issues resolved.
> 
> The scsi disk layer does the entire gendisk stuff itself. Its actually
> very hard for a scsi driver to screw that up - the scsi driver has no
> real concept of a 'disk'. sd talks to a disk and the scsi driver just gets
> messages posted around.
> 
> Alan

Alan,

If you have an adapter, install it, dumop and gendisk head, and take a 
look at what's happening.  I am seeing drives being reported with 0 
block lengths and other wierdness.    

Jeff


