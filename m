Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbUA1TMG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbUA1TMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:12:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:22766 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265919AbUA1TMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:12:03 -0500
To: =?iso-8859-1?Q? "Martin_Schwidefsky" ?= <schwidefsky@de.ibm.com>
Subject: Re: Cset 1.1490.4.201 - dasd naming
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: <linux-kernel@vger.kernel.org>,
       =?iso-8859-1?Q?Pete_Zaitcev?= <zaitcev@redhat.com>,
       =?iso-8859-1?Q?Horst_Hummel?= <Horst.Hummel@de.ibm.com>
Message-Id: <26879984$10753165904018076eb99703.79657228@config1.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 26879984
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Wed, 28 Jan 2004 20:10:02 +0100
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That is probably the main argument to go back to the old names. After
> udev and friends are in place it is not important how the disk is named
> internally. The only place where it would surface is on the root=
> parameter.

Even for root=, it probably does not matter as long as udev is used
in the initrd/initramfs. The main argument against the new naming is
that udev can trivially create these or other persistent names, while
it's very hard for udev to calculate the compatible names.

        Arnd <><
