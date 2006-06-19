Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWFSJa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWFSJa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWFSJa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:30:29 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:65164 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932210AbWFSJa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:30:28 -0400
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
From: Marcel Holtmann <marcel@holtmann.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-hotplug-devel@vger.kernel.org
In-Reply-To: <20060619082355.GE4253@implementation.labri.fr>
References: <20060618221343.GA20277@kroah.com>
	 <20060618230041.GG4744@bouh.residence.ens-lyon.fr>
	 <20060618231204.GB2212@suse.de>
	 <20060618233508.GH4744@bouh.residence.ens-lyon.fr>
	 <20060619032259.GB4651@suse.de>
	 <20060619082355.GE4253@implementation.labri.fr>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 11:30:31 +0200
Message-Id: <1150709431.4277.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

> > Or just tell your users to make sure that they have the uinput driver
> > loaded,
> 
> They can't, since without it they can't even type things.

if you install a program or a driver that needs uinput loaded, then you
have a clean requirement. So simply add a "modprobe uinput" to its init
script.

Look at the TUN/Tap driver which has the same problem. The boot up
scripts of various daemons (for example OpenVPN etc.) are making sure
that the driver is loaded.

Regards

Marcel


