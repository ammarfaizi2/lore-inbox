Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWJQSSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWJQSSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWJQSSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:18:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:48351 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751189AbWJQSSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:18:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tq8BYNPopUA4r6y7JIREsWgcvTF71pykh1F06e5FNe4qpGcGELvt8y6RkwgjMk3lPNJiNHNMwxHIeXU4vJrSPBzu9YYQt1U4GS+G/xjc+Be4vxPioqqK9dyaNBOzvII2MhDnBTlOl2sw0+u479OeDXlnPQLxc5U/xwG/v492XRE=
Message-ID: <c43b2e150610171116w2d13e47ancbea07c09bd5ffbf@mail.gmail.com>
Date: Tue, 17 Oct 2006 20:16:35 +0200
From: wixor <wixorpeek@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: VCD not readable under 2.6.18
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161040345.24237.135.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com>
	 <1161040345.24237.135.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Multimedia sectors on a VCD are not readable by dd or the filesystem
> layer, you must use a specific vcd player app so the dd test fail is
> expected.
Hmm.... so this is more like audio CD with separate tracks and no data
track than like film on DVD? OK then, but how does xine tell kernel
"give me video tracks"? Is there some magic switch_to_video ioctl on
cdrom devices or what? And should the dd test fail with kernel errors
or just with dd saying 'the device is empty'? And why even hal doesn't
recognize the disc as video cd, but recognizes audio cds? (ok, it does
not recognize all video cds I have, but only this one is unplayable,
so it is probably lack of support, just asking to make sure).

>The xine one is more interesting. Is Xine being fooled by the
>fact its a multisession disk of some form perhaps >?
The xine does not display any errors. It just hangs and I have to kill
(-TERM is enough) it. Well..... i have no idea, really. The original
CD is bought, so i suspect it is classical old-style traditional disc
with no multi sessions. It is compatibile with VCD2.0 standard as far
as i remember, but I might be wrong as well. The copy of it I made is
made by nero express & windows xp on other machine, so I belive it is
bitwise exact (which is propably wrong, but... :D). The both original
and copy behave in the same way. Is there any way to dump the disc
structure?

One more - winxp shows files and directories on this linux-unplayable
vcd. Is it like there no directories in fact, and all this contents is
just file virtualization of the vcd tracks (but why the hell would be
autorun.inf and some executable !! file there?) or there is some data
track there, but it is non-standard or not supported? I can provide
you with nero image of the disc i have used during copying
(450mbytes), but i'm not broadband, and you propably also have some
better things to transmit, so....

Thanks for replies
--
wixor
