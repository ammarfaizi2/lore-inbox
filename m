Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbUJ0Ot7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbUJ0Ot7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbUJ0Ot7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:49:59 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:14266 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262467AbUJ0Otz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:49:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=G8ikZ9Hd3BGeDQ8H6p8JONuIqz8Or7KH28B2Lrp4p2gDW1p6w2p78Wg9Ij+lck8q+lKS/ibSwxxbgCF+j/T8KuOwOVGyp79frp94vJn2ikcgvLrkD7AqLz3lZFrNKWn9XS1NmV+b9+lHACFVJtxykmQDdmyn4kcZxS6aR8/fvXE=
Message-ID: <58cb370e0410270749f717585@mail.gmail.com>
Date: Wed, 27 Oct 2004 16:49:55 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [BK PATCHES] ide-2.6 update
Cc: CaT <cat@zip.com.au>, torvalds@osdl.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <16767.45494.863511.334215@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <58cb370e04102706074c20d6d7@mail.gmail.com>
	 <20041027133431.GF1127@zip.com.au>
	 <58cb370e04102706512283405@mail.gmail.com>
	 <16767.45494.863511.334215@alkaid.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 16:33:26 +0200, Mikael Pettersson <mikpe@csd.uu.se> wrote:
> Bartlomiej Zolnierkiewicz writes:
> 
> 
>  > http://bugme.osdl.org/show_bug.cgi?id=2494
>  >
>  > On Wed, 27 Oct 2004 23:34:31 +1000, CaT <cat@zip.com.au> wrote:
>  > > On Wed, Oct 27, 2004 at 03:07:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
>  > > > <bzolnier@trik.(none)> (04/10/26 1.2192)
>  > > >    [ide] pdc202xx_old: PDC20267 needs the same LBA48 fixup as PDC20265
>  > >
>  > > What would the symptoms of this bug be? I've got a PDC20267 and I'm
>  > > having a few issues transferring from hde to hdh (ie across two ports)
>  > > it seems. My work at duplicating things seems to work best when I do a
>  > > transfer like that rather then going from say, a totall different
>  > > controller to the pdc (hdh) or even from generated input to the pdc (hdh).
> 
> I see only one note where someone claims the '67 is affected.
> What would trigger it? A large disk or just heavy I/O?
> FWIW, my news server has received, stored, manipulated, and sent >500
> gigabytes of data using a lowly 20267 add-on card in a 440BX mobo,
> and has _never_ had any problems, and I/O is sometimes very heavy.

request with number of sectors > 256 on LBA48 capable disk
(!= large disk)
