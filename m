Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132767AbRBEETL>; Sun, 4 Feb 2001 23:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132749AbRBEETB>; Sun, 4 Feb 2001 23:19:01 -0500
Received: from www.llamacom.com ([209.152.94.130]:61957 "HELO www.llamacom.com")
	by vger.kernel.org with SMTP id <S132767AbRBEESp>;
	Sun, 4 Feb 2001 23:18:45 -0500
Date: Sun, 4 Feb 2001 22:18:42 -0600 (CST)
From: Eric Molitor <emolitor@molitor.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Wavelan IEEE driver 
In-Reply-To: <200101302222.OAA04184@nova.botz.org>
Message-ID: <Pine.LNX.4.10.10102042217210.27031-100000@www.llamacom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I dropped a patch to 2.4.1 with the updated wavelan driver at the
following locations. It should work with the new firmware. (Its the 1.06
wavelan driver)

http://www.molitor.org/wavelan/
http://omega.uta.edu/~emm7993/wavelan/

- Eric Molitor
  Please CC me on the reply as I'm not on the kernel mailing list...

On Wed, 31 Jan 2001, Tobias Ringstrom wrote:

> On Tue, 30 Jan 2001, Jurgen Botz wrote:
> > and appears to work.  I did observe a problem with iwconfig dumping
> > core, but it seems to do its job before it dies, so this may be non-
> > critical.
> 
> Make sure you compile wireless-tools using the right headers.  You must
> manually insert -I/path/to/running-linux-version/include in the Makefile.
> 
> This is due to a bad (non-existing) ioctl backward and forward
> compatibility, and is being worked on.  Basically, you cannot use the
> tools compiled with one version of the wireless extension headers on a
> kernel with another version of the wireless extensions.  The symptom is at
> best a SEGV, but you may also get strange values.
> 
> /Tobias
> 
> 
> 
> 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
