Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbVKQAbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbVKQAbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbVKQAbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:31:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26884 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161045AbVKQAbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:31:15 -0500
Date: Thu, 17 Nov 2005 01:31:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Oliver Neukum <oliver@neukum.org>, jmerkey <jmerkey@utah-nac.org>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051117003115.GT5735@stusta.de>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <200511161630.59588.oliver@neukum.org> <1132155482.2834.42.camel@laptopd505.fenrus.org> <200511161710.05526.ak@suse.de> <20051116184508.GP5735@stusta.de> <20051117000654.GA11128@wohnheim.fh-wedel.de> <437BB7D1.2090109@wolfmountaingroup.com> <437BB8A3.9030701@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437BB8A3.9030701@wolfmountaingroup.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 03:54:27PM -0700, Jeffrey V. Merkey wrote:
> > 
> >The SCSI layer needs to be checked.  I reproduced another crash on 
> >today on an older Niksun box running off the end of the stack.
> >
> >Jeff
> >
> >
> It's somewhere in the scanning code.  There's a case where it runs off 
> the end of the stack.  Check the compaq drivers for SATA as well, they 
> also crash in a similiar place during bus scan.  Both occurred during 
> bootup, so I wasn't able to get a log of the particulars.  Should be 
> easy to reproduce.  Compaq Presario 2200.

Are you using completely unmodified ftp.kernel.org kernels?

Which version?

If it occurs during bootup, you should see the error displayed.
Please use a digital camera to photograph the error and send a linkt ot 
the photo.

> Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

