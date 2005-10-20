Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVJTWDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVJTWDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVJTWDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:03:38 -0400
Received: from smtp-out.google.com ([216.239.45.12]:37020 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932540AbVJTWDh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:03:37 -0400
Message-ID: <4a45da430510201503v74874acoca37bba3aa5a2d07@mail.google.com>
Date: Thu, 20 Oct 2005 15:03:30 -0700
From: Jonathan Mayer <jonmayer@google.com>
To: dtor_core@ameritech.net
Subject: Re: [PATCH] added sysdev attribute to sysdev show/store methods - for linux-2.6.13.4
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000510201459y25a2c8e5v55bf830c445c9dbf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com>
	 <d120d5000510201459y25a2c8e5v55bf830c445c9dbf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Surely, the organization of sysfs is logical (by grouping relating
things) rather than functional (by grouping things that need common
back-end interfaces).

Er .. no?

In general, where can I find guidance on where to put things within
sysfs?  Has anybody written some kind of Plan?

 - jm.

On 10/20/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 10/20/05, Jonathan Mayer <jonmayer@google.com> wrote:
>
> >  2. it precludes the ability to create sys_device objects whose
> > attributes are not known at compile time (such as an sysfs
> > representation of the smbios table for some platforms -- which will be
> > my next patch submission).
> >
>
> Does this smbios table have to be a system device (does it have to be
> suspended and resumed with interrupts off) or maybe platform bus suits
> it better?
>
> --
> Dmitry
>
