Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbWIRN4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWIRN4g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWIRN4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:56:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:4571 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965226AbWIRN4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:56:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dbFQirezHqJ9F8frNv4nZD4MxmQ1SAsjent2T8+NMaxihfFtxR4HPjJt7iUPWxpzafXFSx/IlUEZcLVUd2CZ31vUbxWSuTf85KDJgbldtxDPy6LejYP7K0lPlFMYte9DhRdaFvXHtGcHrdYtfww7TcRTYoLxfNhpnZ+dT68ooH8=
Message-ID: <d120d5000609180656t2c6be385r4ad21d52313ac187@mail.gmail.com>
Date: Mon, 18 Sep 2006 09:56:33 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
Subject: Re: Exporting array data in sysfs
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200609181541.57164.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609181359.31489.eike-kernel@sf-tec.de>
	 <20060918124425.GA8304@kroah.com>
	 <200609181541.57164.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> Greg KH wrote:
> > On Mon, Sep 18, 2006 at 01:59:17PM +0200, Rolf Eike Beer wrote:
> > > Hi,
> > >
> > > I would like to put the contents of an array in sysfs files. I found no
> > > simple way to do this, so here are my thoughts in hope someone can hand
> > > me a light.
> >
> > What is wrong with using an attribute group for this kind of
> > information?
>
> Missing documentation. Yes, this looks like I could use this at least for the
> simple interfaces (which would be enough).
>

I imoplemented sysfs arrays and array groups once:

http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/1155.html

Not sure if it still appliers. Maybe Greg will consider taking it in
if there is a user of this code.

-- 
Dmitry
