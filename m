Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUHDUcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUHDUcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUHDUcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:32:07 -0400
Received: from mproxy.gmail.com ([216.239.56.248]:45400 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267409AbUHDUcB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:32:01 -0400
Message-ID: <944a037704080413321617ac3c@mail.gmail.com>
Date: Wed, 4 Aug 2004 16:32:00 -0400
From: Michael Guterl <mguterl@gmail.com>
To: "Luis Miguel =?ISO-8859-1?Q?=20Garc=EDa?= Mancebo" <ktech@wanadoo.es>
Subject: Re: USB troubles in rc2
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200408040104.00177.ktech@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200408022100.54850.ktech@wanadoo.es> <200408031046.57137.ktech@wanadoo.es> <20040803135730.GB13390@kroah.com> <200408040104.00177.ktech@wanadoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.7-mm7 doesn't work
2.6.7-mm7 (with bk-usb.patch reverted) works

2.6.8-rc2 doesn't work
2.6.8-rc2-mm2 doesn't work
2.6.8-rc2-mm2 (with bk-usb.patch reverted) doesn't work

I will test rc1 later tonight once I get off work and post the results.

As stated earlier machine hangs on Starting cups.  If I disconnect all
USB devices it boots, but when I plug my keyboard in, nothing works
unless I hold down a key for a few seconds.  Then the input is shown
on the machine but repeatedly, like I was holding the key.  Example
I'll hold the "s" key and it appears after a few seconds, but like
"sssssssssssssssssssssssssss"  if I hit backspace nothing, but if I
hold it, it will erase all the characters.

Please CC to linux-usb-devel as I am not subscribed.

On Wed, 4 Aug 2004 01:04:00 +0200, Luis Miguel García Mancebo
<ktech@wanadoo.es> wrote:
> El Martes, 3 de Agosto de 2004 15:57, Greg KH escribió:
> > On Tue, Aug 03, 2004 at 10:46:57AM +0200, Luis Miguel Garc?a Mancebo wrote:
> > > With 2.6.7-mm7 don't work either, but I can revert the bk-usb.patch in
> > > the andrew tree and all works ok. Even the camera:
> >
> > So 2.6.7 (with no patches) worked for you?  Did 2.6.8-rc1 break?  Or was
> > it 2.6.8-rc2 that broke your box?
> >
> > thanks,
> >
> > greg k-h
> 
> I have been testing various kernels. Here's the restult:
> 
> 2.6.7-mm7   DON'T WORK
> 2.6.7-mm7 (with bk-usb.patch reverted) WORKS
> 
> 2.6.7-rc1    DON'T WORK
> 2.6.7-rc2    DON'T WORK
> 
> So I think the problems started on vanilla in 2.6.8-rc1 but was already there
> in 2.6.7-mm7.
> 
> Thanks  a lot. Any patch do you want for me to test?
> 
> 
> 
> --
> Luis Miguel García Mancebo
> Universidad de Deusto / Deusto University
> Spain
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
