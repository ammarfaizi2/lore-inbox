Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTHUS2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 14:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTHUS2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 14:28:12 -0400
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:51081 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S262872AbTHUS2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 14:28:12 -0400
Subject: Re: Initramfs
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: gkajmowi@tbaytel.net, linux-kernel@vger.kernel.org
In-Reply-To: <3F44D504.7060909@pobox.com>
References: <200308210044.17876.gkajmowi@tbaytel.net>
	 <1061447419.19503.20.camel@camp4.serpentine.com>
	 <3F44D504.7060909@pobox.com>
Content-Type: text/plain
Message-Id: <1061490490.23060.9.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Aug 2003 11:28:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-21 at 07:19, Jeff Garzik wrote:

> Support replacing "initrd=" with "initramfs=", so that bootloaders can 
> pass a cpio image into the standard initrd memory space.

That would be nice to have, but it would also increase the pressure to
fix the cpio unpacker.  At least right now, its deficiencies don't cause
many problems, because initramfs is less than convenient to use.

	<b

