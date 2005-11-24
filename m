Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVKXPad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVKXPad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKXPac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:30:32 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:39266 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932105AbVKXPab convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:30:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ij/P707Cz+j09AkzkPa1b+lt0z/IAYHWvu0gpNtpS1+shP+smL2wR+/Rkzj+v3XQP76xHJD9yo4ECa7BVvjUiuqmOubxiAi5Ppj0RYVg4lDlWcbvU6WLQftbxZ6qSVqSDxgOPjMCs4pOVjNpyKmxhEDfIDCp9wmD0ShJ0qi18MA=
Message-ID: <6c18a4f0511240730md9adb28xf7c2f0403621a6c4@mail.gmail.com>
Date: Thu, 24 Nov 2005 16:30:30 +0100
From: Bernd Bartmann <bernd.bartmann@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: S.M.A.R.T. command passthru to Firewire devices
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1132847917.13095.115.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6c18a4f0511240601i5860f724rff4db0c1b1fdca1e@mail.gmail.com>
	 <1132847917.13095.115.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2005-11-24 at 15:01 +0100, Bernd Bartmann wrote:
> > When I try to run "smartctl -a /dev/sdb" it tells me that "Device does
> > not support SMART". /dev/sdb is a normal hdd in an external firewire
> > enclosure. To me this looks like the firewire SCSI layer does not
> > support the passthru of the S.M.A.R.T. commands. Or is there any other
> > way to query the S.M.A.R.T. status of an hdd attached via Firewire?
>
> If it takes an ATA drive then you will probably be seeing the fact that
> most firewire<->ATA convertor units don't support SMART so don't offer
> it over their SCSI interface.

So this means it is a problem of the firmware in the Firewire
enclosure? Are there any known enclosures that do support this
feature?

Best regards,
Bernd.
