Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWBBXzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWBBXzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWBBXzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:55:37 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54721 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932497AbWBBXzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:55:36 -0500
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060202214059.GB14097@stusta.de>
References: <20060131213306.GG3986@stusta.de>
	 <1138743844.3968.14.camel@localhost.localdomain>
	 <20060202214059.GB14097@stusta.de>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 00:57:01 +0100
Message-Id: <1138924621.3788.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> > > This patch contains the following cleanups:
> > > - move the help text to the right option
> > > - replace some #ifdef's in capi.c with dummy functions in capifs.h
> > > - use CONFIG_ISDN_CAPI_CAPIFS_BOOL in one place in capi.c
> > 
> > I actually still like to see capifs removed completely. It is not really
> > needed if you gonna use udev. The only thing that it is doing, is to set
> > the correct permissions and make sure that the device nodes are created.
> > And with a 2.6 kernel this can be all done by udev.
> 
> udev is not mandatory.
> 
> Static /dev is still 100% supported and working fine.

and if you have static /dev then you can use mknod and chown by
yourself. If you use CAPI on any newer distribution with the latest 2.6
kernel you will have udev anyway and so no static /dev at all.

Regards

Marcel


