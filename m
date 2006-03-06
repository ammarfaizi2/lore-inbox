Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWCFKQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWCFKQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 05:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWCFKQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 05:16:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750766AbWCFKQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 05:16:01 -0500
Date: Mon, 6 Mar 2006 02:14:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, bastian@waldi.eu.org,
       heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com
Subject: Re: + s390-add-modalias-to-uevent-for-ccw-devices.patch added to
 -mm tree
Message-Id: <20060306021416.5eedf2ad.akpm@osdl.org>
In-Reply-To: <20060306110416.1e14933f@gondolin.boeblingen.de.ibm.com>
References: <200603060714.k267E6gN021778@shell0.pdx.osdl.net>
	<20060306110416.1e14933f@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
>
> On Sun, 05 Mar 2006 23:12:30 -0800
> akpm@osdl.org wrote:
> 
> > From: Bastian Blank <bastian@waldi.eu.org>
> > 
> > Add a MODALIAS line to the uevents generated for ccw devices.  udev uses
> > them to load modules.
> > 
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> > 
> >  drivers/s390/cio/device.c |   40 ++++++++++++++++++++++++++----------
> >  1 files changed, 29 insertions(+), 11 deletions(-)
> 
> Hm, didn't see this on lkml, but the patch looks fine.

It was a best guess, based upon random URLs which people were tossing around.
(I did ask to be emailed the updated patch).

> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

OK, but if you're prefer to do it differently, please send the patch.  Via
email ;)

