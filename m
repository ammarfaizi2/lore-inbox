Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWJ0XMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWJ0XMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWJ0XMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:12:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:52881 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751034AbWJ0XML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:12:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hamPzXtB+JEDobSifha9/6jGsMpY0TXLODMUDjyoz5h1YOSwuVm+IvDvZTD4vc9jQNlY2cINR5QkVDylV1Fd8MqB4lFxeVzE4kbv9KmVJy0bGZ0mXjVthos/zSW79Y2HTPmxPgC8X2GhnAVZtB0tb/xMXEvAdAapcbllOvw/I60=
Message-ID: <45429240.1080800@gmail.com>
Date: Fri, 27 Oct 2006 19:12:00 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       proski@gnu.org, cate@debian.org, gianluca@abinetworks.biz
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	 <1161808227.7615.0.camel@localhost.localdomain>	 <20061025205923.828c620d.akpm@osdl.org>	 <20061026102630.ad191d21.randy.dunlap@oracle.com>	 <1161959020.12281.1.camel@laptopd505.fenrus.org>	 <20061027082741.8476024a.randy.dunlap@oracle.com>	 <20061027112601.dbd83c32.akpm@osdl.org>  <45428EAD.6040005@gmail.com> <1161990307.16839.50.camel@localhost.localdomain>
In-Reply-To: <1161990307.16839.50.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-10-27 am 18:56 -0400, ysgrifennodd Florin Malita:
>   
>> Also, since driverloader is not GPL-compatible (MODULE_LICENSE("see
>> LICENSE file; Copyright (c)2003-2004 Linuxant inc.")), that check is
>> redundant. How about removing it (applies on top of Randy's patch)?
>>
>>
>> Signed-off-by: Florin Malita <fmalita@gmail.com>
>>     
>
> NAK
>
> Older versions of Linuxant's driverloader claim GPL\0some other text and
> systematically set out to abuse the license tag code. We should continue
> to carry the code for this.
>   

Older versions of driverloader won't even build for recent kernels
(actually even the latest - 2.34 - fails with 2.6.19-rc3). Do you know
of any driverloader version that actually works with 2.6.18+ and
misrepresents its license? Seems to me they gave up that practice and
currently the check is useless but if you want to keep it as a statement
I can understand that :)

---
fm
