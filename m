Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVBUXLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVBUXLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 18:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVBUXLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 18:11:39 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:19877 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262168AbVBUXLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 18:11:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hIQ6QB2j1rD3xIChMACQyKjTNerXu0KVZfhxJo5e3GTdP0vnoILztEp4x1vEObfixjLXTYLcXNPNtLwL24poEKjYd6fk+8lYyFzGTxNfZJylT0nDWKOuA6vwtYCGyZLqqzq7k8kNEVXp+T0gwkPtbscC5Uyx831+WVoDON1wsYc=
Message-ID: <29495f1d050221151168548698@mail.gmail.com>
Date: Mon, 21 Feb 2005 15:11:36 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Anthony DiSante <theant@nodivisions.com>
Subject: Re: uninterruptible sleep lockups
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <421A6450.8070404@nodivisions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <421A3414.2020508@nodivisions.com>
	 <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>
	 <421A4375.9040108@nodivisions.com>
	 <200502212054.j1LKs3xi032658@turing-police.cc.vt.edu>
	 <421A6450.8070404@nodivisions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 17:44:32 -0500, Anthony DiSante
<theant@nodivisions.com> wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > See the thread rooted here:
> >
> > Date: Wed, 03 Nov 2004 07:51:39 -0500
> > From: Gene Heskett <gene.heskett@verizon.net>
> > Subject: is killing zombies possible w/o a reboot?
> > Sender: linux-kernel-owner@vger.kernel.org
> > To: linux-kernel@vger.kernel.org
> > Reply-to: gene.heskett@verizon.net
> > Message-id: <200411030751.39578.gene.heskett@verizon.net>
> 
> Also, one of the things mentioned in that thread is that whenever a driver
> is waiting on I/O from a piece of hardware, there should always be some
> timeout code.  Is that the root of the permanent D state?  Is it always a
> process waiting on a piece of hardware that should be eventually timing out,
> except the timeout code isn't there?

If you would like to file a bugzilla bug (or reference one if you
already have) -- http://bugzilla.kernel.org -- it would be easier to
track the problems. It would be good to get some idea of what hardware
is running (and thus what drivers) to debug further.

Thanks,
Nish
