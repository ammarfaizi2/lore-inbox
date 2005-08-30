Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVH3LH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVH3LH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 07:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVH3LH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 07:07:56 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:55708 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751202AbVH3LH4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 07:07:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aNkfkjpoyt9DS7z3cb9xZHdgR11oqsMMvgxdXero9MZJjqnKCF7BEswa6mD6471OLLqowy4uDfxgIllCLaSBYTW243coIlJZMvOBl3hw6zmgBChSojA77pVMG1GLj1r5Icc2X/DSe70J6IPxc9JR5r9OFy5Eq66KGhH/vkyyezE=
Message-ID: <7cd5d4b405083004072c30dffd@mail.gmail.com>
Date: Tue, 30 Aug 2005 19:07:55 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: sr device can be written?
In-Reply-To: <20050830095359.GA15431@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c3c37c55050829215355bb85f4@mail.gmail.com>
	 <20050830080812.GA13394@localhost.localdomain>
	 <7cd5d4b40508300111260d6b9a@mail.gmail.com>
	 <20050830095359.GA15431@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

but It seems that I can not open sr0 with openflags O_RDWR,why?
open("/dev/sr0",O_RDWR);

It says:sr0 is a read only file sytem.
why?

On 8/30/05, Tino Keitel <tino.keitel@gmx.de> wrote:
> On Tue, Aug 30, 2005 at 16:11:58 +0800, jeff shia wrote:
> > YOu mean the device file can be written?
> 
> Yes, like an ordinary block device.
> 
> >
> >
> > On 8/30/05, Tino Keitel <tino.keitel@gmx.de> wrote:
> > > On Tue, Aug 30, 2005 at 12:53:51 +0800, jeff shia wrote:
> > > > Hello,
> > > >  Sr is the Scsi-cdrom device?so it can be read only?but look at the source=
> > > > =20
> > > > code I notice that
> > > > sr can be written also!Is it right?
> > >
> > > Just imagine a DVD-RAM drive.
> > >
> > > Regards,
> > > Tino
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
