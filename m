Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281196AbRKEP54>; Mon, 5 Nov 2001 10:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281198AbRKEP5p>; Mon, 5 Nov 2001 10:57:45 -0500
Received: from mail010.mail.bellsouth.net ([205.152.58.30]:52203 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281196AbRKEP5e>; Mon, 5 Nov 2001 10:57:34 -0500
Message-ID: <3BE6B6E3.9A9176DA@mandrakesoft.com>
Date: Mon, 05 Nov 2001 10:57:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: szgyurko@mail.inno.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: drivers/net/fealnx.c error
In-Reply-To: <20011105155137.B28689@morpheus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szabolcs Gyurko wrote:
> 
> Hi,
> 
> there are an error in the 2.4.13 (i think the newest) kernel at the
> drivers/net/fealnx.c file at the 1818 line. The original line:
> 
> static struct pci_device_id fealnx_pci_tbl[] = __devinitdata {
> 
> and the fixed line:
> 
> static struct pci_device_id fealnx_pci_tbl[] __devinitdata = {

I have this change locally, it will go to Linus when he starts taking
patches again...

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

