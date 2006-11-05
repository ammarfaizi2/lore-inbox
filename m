Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965884AbWKEOlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965884AbWKEOlO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 09:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965886AbWKEOlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 09:41:14 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:36742 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S965884AbWKEOlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 09:41:13 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Scsi cdrom naming confusion; sr or scd?
Date: Sun, 5 Nov 2006 15:41:37 +0100
User-Agent: KMail/1.8
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, andrew@walrond.org,
       linux-kernel@vger.kernel.org
References: <20061105100926.GA2883@pelagius.h-e-r-e-s-y.com> <Pine.LNX.4.61.0611051232580.12727@yvahk01.tjqt.qr> <1162735599.3160.91.camel@laptopd505.fenrus.org>
In-Reply-To: <1162735599.3160.91.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611051541.37283.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 5. November 2006 15:06 schrieb Arjan van de Ven:
> and this is why it's wrong to make naming policy a kernel thing!
> Userspace is the right place to do this (and there I suspect the name
> will end up being /dev/cdrom)...... the kernel really shouldn't care at
> all what the name is.

I have to disagree. This precisely shows that the reverse is true.
This way the chance of having a default name guaranteed to work
is lost. If you want an alternate name, use a symlink.

	Regards
		Oliver
