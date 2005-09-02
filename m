Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVIBO1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVIBO1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVIBO1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:27:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58283 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750899AbVIBO1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:27:20 -0400
Subject: Re: IDE HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: ataraid-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f05090206331d04afd3@mail.gmail.com>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 15:50:59 +0100
Message-Id: <1125672660.30867.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-02 at 15:33 +0200, Molle Bestefich wrote:
> > It also wouldn't solve the case of a file system that spans both inside and
> > outside the HPA.
> 
> If HPA were exposed as /dev/.../hpa then it wouldn't be possible to
> create such a filesystem. I'm guessing it's not possible with Windows
> either, or with any BIOS-based OS.

It is on many windows systems which include extra drivers that come with
large disks.

> Creating filesystems that include the HPA defeats the entire idea of
> the HPA in the first place.

See previous discussion, this is untrue. It may not have been the intent
of the standards authors but its certainly the idea of a large number of
disk and system vendors that the HPA is a handy way to deal with old
BIOSes and other items of that nature.
  
> If one does not care to use the HPA, one should disable it in the BIOS
> entirely, so that everywhere (!) the entire disk is seen.

And in the real world BIOSes don't get updated often by vendors let
alone by users.

