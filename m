Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWGGS7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWGGS7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWGGS7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:59:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:11630 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932257AbWGGS7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:59:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T+SUW67keGwnGKgDoxZt5A2GyWEOM8gOrs+vcE8eRzZS+B7AsqVrkekMqw0qawvADAgBcvdcGiiBdbu6vAO4lElznl9BaM0j91QbdZphYKcafhzDLBzUKbts3C0tQoZ/ub8PDv2GWdI9yzSsd1HE3/d1ukYdpK0EYqyc63RRjVg=
Message-ID: <b637ec0b0607071159q50e24519jdfbbbef3271a8975@mail.gmail.com>
Date: Fri, 7 Jul 2006 20:59:19 +0200
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: 2.6.17-mm6 libata stupid question...
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <44ADF244.5050504@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu>
	 <44ADF244.5050504@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 7/7/06, Jeff Garzik <jeff@garzik.org> wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > There's only one minor detail - although the CD is (AFAIK) a UDMA/33 device,
> > the hard drive and the controller are both able to do UDMA/100.
>
> Currently both master and slave are forced to the least common
> denominator speed.
>
> Alan Cox has fixed this in a patch, for the controllers that allow
> master and slave to run at different bus speeds (most allow this).

Wil this patch be included in next -mm?

>
>         Jeff
>

Fabio
