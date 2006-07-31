Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWGaOnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWGaOnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWGaOng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:43:36 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:16569 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750892AbWGaOng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:43:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KL5G0MxPSih1+CHpwNQGY5N0zgvIpBiZu95eB5yySmEIAhY6vsjLA1arhof0gxPD9xYI86/H4wIL7Xekh/IZR9IM7nzmr67+e9aaR97xyzS7+iZ172dflEKeoc2dILPiS9Fa8mk1I7tqXZmeC9o2+PQ10xW7cbaI57yylKgyCOc=
Message-ID: <3b2bc9d0607310743r2ad59c59xfe0898f685e33329@mail.gmail.com>
Date: Mon, 31 Jul 2006 16:43:35 +0200
From: "marco gaddoni" <marco.gaddoni@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fwd: PROBLEM: ide messages during boot caused by a strange partition table
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1154356290.7230.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3b2bc9d0607302313p637ce780sf98b1727213bd6a2@mail.gmail.com>
	 <3b2bc9d0607302316s68734797r212e0a422ed26a50@mail.gmail.com>
	 <1154343947.7230.15.camel@localhost.localdomain>
	 <3b2bc9d0607310617p21552cc8xba66f935b9ec73bd@mail.gmail.com>
	 <1154356290.7230.31.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-31 am 15:17 +0200, ysgrifennodd marco gaddoni:
> > is it correct that the max lba sect is LBAsects=156368016 and the kernel
> > is asking for 1052835654, 10 times more ?
>
> No you are right - I miscounted the digits in the original report.
>
> I'm still dubious the partition table is involved unless you've since
> booted Windows and the two have been overwriting bits of each other.
>
> What tool created the broken partition table - do you know, and which OS
> was installed first ?
>
>
the disk before was correctly booting linux and windows2000.
then i used the dos6.22 fdisk (?? unsure about the exact dos version)
to delete and recreate a partition. then a began a format /s and
interrupted hafway because it was too slow.
i am not sure that the partition i deleted with fdisk was the first of
the disk.
It was some time ago, i dont remember clearly.
