Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264543AbRFTSfC>; Wed, 20 Jun 2001 14:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264545AbRFTSex>; Wed, 20 Jun 2001 14:34:53 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:37145 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264543AbRFTSel>;
	Wed, 20 Jun 2001 14:34:41 -0400
Message-ID: <20010620203444.A22204@win.tue.nl>
Date: Wed, 20 Jun 2001 20:34:44 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Josh Fryman <fryman@cc.gatech.edu>, linux-kernel@vger.kernel.org
Subject: Re: IDE drives mis-reporting size... bug or feature?
In-Reply-To: <3B30E4CC.3794331@cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3B30E4CC.3794331@cc.gatech.edu>; from Josh Fryman on Wed, Jun 20, 2001 at 02:00:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 02:00:44PM -0400, Josh Fryman wrote:

> this is an odd one.  i think it's technically a feature
> but might be perceived instead as a "bug".  anyway, i've
> got a pair of Ultra100 Maxtor 52049h4 20GB drives, on a 
> Promise Ultra 100 (PDC20267) controller.  
> 
> the drives were popped in with the jumper on for the
> 4096 cylinder limit forced.
> 
> the promise controller recognizes the drives on boot-up
> init as being what they are - ~20GB - and continues on
> merrily.  
> 
> Windows 2000 recognizes the drives as ~2GB in size, due to
> the jumper.  it's observing the 4096cyl limit on the drive
> in some way.  (remove the jumper and it sees ~20GB too.)
> 
> Linux 2.4.3 recognizes the drives as ~20GB regardless of
> the jumper.
> 
> so, is this a bug or feature?  is windows or linux not 
> working right here?  what *should* be seen with the drive
> jumpered such?

The jumper is to overcome a BIOS defect.
The operating system should see the true size.
In order to get Windows to see the true size you may need MaxBlast
or similar boot manager stuff.
