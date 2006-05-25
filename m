Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWEYK1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWEYK1Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWEYK1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:27:24 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:26062 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965108AbWEYK1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:27:23 -0400
Subject: Re: [PATCH 1/2] request_firmware without a device
From: Marcel Holtmann <marcel@holtmann.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1148532550.32046.107.camel@sli10-desk.sh.intel.com>
References: <1148529045.32046.102.camel@sli10-desk.sh.intel.com>
	 <20060525040134.GA29974@kroah.com>
	 <1148532550.32046.107.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 12:26:21 +0200
Message-Id: <1148552781.4734.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaohua,

> > > The patch allows calling request_firmware without a 'struct device'.
> > > It appears we just need a name here from 'struct device'. I changed it
> > > to use a kobject as Patrick suggested.
> > > Next patch will use the new API to request firmware (microcode) for a CPU.
> > 
> > But a cpu does have a struct device.  Why not just use that?
> It's a sysdev, no 'struct device' in it, IIRC.

do we really need to differentiate between sysdev and device anymore. I
recall a plan to unify all devices, but I might be wrong.

Regards

Marcel


