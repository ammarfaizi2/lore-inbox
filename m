Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWFTMwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWFTMwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWFTMwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:52:19 -0400
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:61116
	"EHLO echohome.org") by vger.kernel.org with ESMTP id S1750714AbWFTMwS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:52:18 -0400
Message-ID: <22582.216.68.248.2.1150807936.squirrel@www.echohome.org>
In-Reply-To: <1150791627.11062.25.camel@localhost.localdomain>
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAIdWvHE4LIdGgJWKcd2w9I8BAAAAAA==@EchoHome.org>
    <1150791627.11062.25.camel@localhost.localdomain>
Date: Tue, 20 Jun 2006 08:52:16 -0400 (EDT)
Subject: RE: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver 
     for PDC202XX
From: "Erik Ohrnberger" <Erik@echohome.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Reply-To: Erik@echohome.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
    I thank you persaonlly for these pointers.

    Erik.

On Tue, June 20, 2006 04:20, Alan Cox wrote:
> Ar Llu, 2006-06-19 am 18:18 -0400, ysgrifennodd Erik Ohrnberger:
>> Regardless, count me as another one of the interested parties for a
>> cure.
>> I've read the thread, and will prepare two current kernels, one using
>> the
>> PDC202XX_NEW and one using the PDC202XX_OLD configuration options.  I'm
>> hoping that the PDC202XX_OLD will also resolve this issue.
>
> Bartlomiej is the old IDE layer maintainer. I would direct any enquiries
> to him about those drivers.
>
>> Any further advice on how to work around this would be greatly
>> appreciated.
>
> 2.6.17 with the libata pata patch from
> http://zeniv.linux.org.uk/~alan/IDE has a Promise driver for the PDC
> 20268 and higher that was written by Albert Lee. There is also a test
> driver for the older chips (20265 etc).
>
> To try that build 2.6.17 with the patch and then say "N" to CONFIG_IDE,
> "Y" to the SATA options under SCSI and the right controller. It will
> move your disks to /dev/sda /dev/sdb etc as it uses the SCSI layer.
>
> Alan
>


