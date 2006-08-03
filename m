Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWHCMTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWHCMTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 08:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWHCMTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 08:19:53 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:42350 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932411AbWHCMTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 08:19:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VDpzhNGNEuMw5KthiFiGB0+1PA0GrMakoRwymztaUigrnGk3tlt6jlTBI6p6sEX7cnmVOD+6V+3ygaPLNVZl8oLoY8o8Z4Ke/DN2n/LMwP/9fqg/qBZTTGMolIF64L5Jy035Nu+1wQQNYuLZBGzrM/KhKnD/6F8sSU0dv0/Vm6A=
Message-ID: <6bffcb0e0608030519u71af8350k9e3b4f9c75a0b3c8@mail.gmail.com>
Date: Thu, 3 Aug 2006 14:19:51 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: mm snapshot broken-out-2006-08-02-00-27.tar.gz uploaded
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060802183613.792e2488.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608020728.k727SegM012704@shell0.pdx.osdl.net>
	 <6bffcb0e0608021700n49a3ed6cnbbe421a22946f54c@mail.gmail.com>
	 <20060802183613.792e2488.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 3 Aug 2006 02:00:42 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> > On 02/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > > The mm snapshot broken-out-2006-08-02-00-27.tar.gz has been uploaded to
> > >
> > >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-02-00-27.tar.gz
> > >
> >
> > There is something wrong with this kernel. I have noticed, that after
> > 1,5 hour some of the keys on my keyboard doesn't work... amarok
> > doesn't want to play music (30 sec gaps between songs etc.), switching
> > between firefox/openoffice takes 1 min. I don't see nothing special in
> > the logs. It is a CPU scheduler problem?
> >
>
> Could be a timekeeping problem, perhaps.  Is it SMP?

Yes, it is.

>  Is the time-of-day
> increasing at the right speed?

Yes.

>  Does `sleep 5' do the right thing?

Yes, it does.

time sleep 5

real    0m5.016s
user    0m0.000s
sys     0m0.014s

Problems starts after stress testing (LTP).

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
