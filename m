Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUHCXEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUHCXEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 19:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUHCXEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 19:04:12 -0400
Received: from smtp06.ya.com ([62.151.11.163]:62137 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S261184AbUHCXEJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 19:04:09 -0400
From: Luis Miguel =?iso-8859-1?q?Garc=EDa_Mancebo?= <ktech@wanadoo.es>
To: Greg KH <greg@kroah.com>
Subject: Re: USB troubles in rc2
Date: Wed, 4 Aug 2004 01:04:00 +0200
User-Agent: KMail/1.6.82
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net
References: <200408022100.54850.ktech@wanadoo.es> <200408031046.57137.ktech@wanadoo.es> <20040803135730.GB13390@kroah.com>
In-Reply-To: <20040803135730.GB13390@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408040104.00177.ktech@wanadoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Martes, 3 de Agosto de 2004 15:57, Greg KH escribió:
> On Tue, Aug 03, 2004 at 10:46:57AM +0200, Luis Miguel Garc?a Mancebo wrote:
> > With 2.6.7-mm7 don't work either, but I can revert the bk-usb.patch in
> > the andrew tree and all works ok. Even the camera:
>
> So 2.6.7 (with no patches) worked for you?  Did 2.6.8-rc1 break?  Or was
> it 2.6.8-rc2 that broke your box?
>
> thanks,
>
> greg k-h

I have been testing various kernels. Here's the restult:

2.6.7-mm7   DON'T WORK
2.6.7-mm7 (with bk-usb.patch reverted) WORKS

2.6.7-rc1    DON'T WORK
2.6.7-rc2    DON'T WORK


So I think the problems started on vanilla in 2.6.8-rc1 but was already there 
in 2.6.7-mm7.

Thanks  a lot. Any patch do you want for me to test?

-- 
Luis Miguel García Mancebo
Universidad de Deusto / Deusto University
Spain
