Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbQJaP4r>; Tue, 31 Oct 2000 10:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbQJaP4i>; Tue, 31 Oct 2000 10:56:38 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:49930 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129197AbQJaP42>; Tue, 31 Oct 2000 10:56:28 -0500
Date: Tue, 31 Oct 2000 11:58:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Geoff Winkless <geoff@farmline.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.17 & VM: do_try_to_free_pages failed / eepro100
In-Reply-To: <069c01c0434b$ad0c5a50$1400000a@farmline.com>
Message-ID: <Pine.LNX.4.21.0010311155530.1475-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Geoff Winkless wrote:

> Hi
> 
> Searching through the archives I found this post on Tue, Sep 12, 2000 at
> 09:41:13PM +0200 from Octave Klaba
> 
> > Hello,
> > On a high load server, kernel has some errors:
> >
> > VM: do_try_to_free_pages failed for httpd...
> > VM: do_try_to_free_pages failed for httpd...
> > eth0: Too much work at interrupt, status=0x4050.
> > eth0: Too much work at interrupt, status=0x4050.
> >
> > is there somewhere the new version of driver for eepro100
> > to make a test ?
> 
> I'm wondering if anyone has found a solution for this: our mailserver is
> exhibiting the same error message (although no mention of the eth0
> interface, we do also use the eepro100):


Apply the following patch: 

ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2//2.2.18pre17/VM-global-2.2.18pre17-7.bz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
