Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUHPPI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUHPPI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267684AbUHPPI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:08:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42973 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267678AbUHPPH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:07:59 -0400
Date: Mon, 16 Aug 2004 08:07:51 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       zaitcev@redhat.com
Subject: Re: [PATCH 2.4] blacklist a device in usb-storage
Message-Id: <20040816080751.733c188d@lembas.zaitcev.lan>
In-Reply-To: <412066BC.9040503@ttnet.net.tr>
References: <mailman.1092508141.32379.linux-kernel2news@redhat.com>
	<20040815235204.0e9ec874@lembas.zaitcev.lan>
	<412066BC.9040503@ttnet.net.tr>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 10:48:12 +0300
"O.Sezer" <sezeroz@ttnet.net.tr> wrote:

> > I do not understand what the objective might be. Just do not
> > use that thing with Linux kernel 2.4. Why do you wish "to revent
> > usb-storage from taking over this disk"?

> As I said above, I cannot prevent accidentals (VID/PIDs aren't
> printed on the disk, yo know...) And usb-storage must not deal
> with disks that it cannot deal with:
> 1. This particular disk can lead to panics as I said.
> 2. If someone ever writes a driver specific to this device (I
>     know it's less than highly unlikely), than it would be also
>     useful in that case if the disk isn't tried to be owned by
>     usb-storage. That, I think applies as a general case, too.

The #2 only makes sense when such driver appears.

As for #1, why don't you post the dmesg from your "panic".

-- Pete
