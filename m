Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbTHUWbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 18:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbTHUWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 18:31:46 -0400
Received: from almesberger.net ([63.105.73.239]:23050 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262398AbTHUWbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 18:31:45 -0400
Date: Thu, 21 Aug 2003 19:31:13 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, gkajmowi@tbaytel.net,
       linux-kernel@vger.kernel.org
Subject: Re: Initramfs
Message-ID: <20030821193113.A3448@almesberger.net>
References: <200308210044.17876.gkajmowi@tbaytel.net> <1061447419.19503.20.camel@camp4.serpentine.com> <3F44D504.7060909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F44D504.7060909@pobox.com>; from jgarzik@pobox.com on Thu, Aug 21, 2003 at 10:19:48AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Support replacing "initrd=" with "initramfs=", so that bootloaders can 
> pass a cpio image into the standard initrd memory space.

This sounds like a very good idea, yes.

Or, maybe even make it such that initramfs acts like a file system,
that will just de-cpio the content of a block device to a ramfs.

Pro:
 - requires less or no changes to existing initrd
 - one can experiment with initramfs loaded from other sources than
   an initrd

Contra: 
 - needs more infrastructure than plain initramfs

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
