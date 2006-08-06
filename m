Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWHFUIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWHFUIL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 16:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWHFUIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 16:08:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:2220 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750702AbWHFUIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 16:08:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N+rUGepF8JxeVo3Rlk067dpcJMahpwK7ryxLPEM2tGZ/CpNEtEOgQAw8pF1lCNe65VX9UviOILxrqCVXZ2E7ii1SBk974z75IwQjBrmZRQtkOi3/idUWsOnS3oEMxuYmgulH19vkJw3ohrwfGNMEVy92zAPXqSXkwmcWpZKPmcM=
Message-ID: <6de39a910608061308t4c9dd9fdo3e1ff634a3079e3d@mail.gmail.com>
Date: Sun, 6 Aug 2006 13:08:08 -0700
From: "Om N." <xhandle@gmail.com>
To: "Om N." <xhandle@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: writing portable code based on BITS_PER_LONG?
In-Reply-To: <20060806103143.GR20586@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6de39a910608052316x37ae7268j5ea18b6ea26219c5@mail.gmail.com>
	 <20060806103143.GR20586@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/06, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Sat, 2006-08-05 23:16:29 -0700, Om N. <xhandle@gmail.com> wrote:
> > I am trying to port a driver written for IA32. This is a pci driver
> > and has a chipset doing PCI <-> local bus data transfer, where local
> > bus is 16 bit. So a number of values are converted by right/left
> > shifting by 16 bits.
> I'd probably write some macros that access the parts of the longs you
> want to have/set and put these into some header file.
Let me go the macro way. Let me beat the code into some shape and then
post a url to the list for comments on 64bit safeness.

Thanks for ideas,
Regards,
Om.
