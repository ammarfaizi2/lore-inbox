Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbTHUWmG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 18:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbTHUWmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 18:42:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6122 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262920AbTHUWmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 18:42:04 -0400
Message-ID: <3F454AA5.3000602@pobox.com>
Date: Thu, 21 Aug 2003 18:41:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: "Bryan O'Sullivan" <bos@serpentine.com>, gkajmowi@tbaytel.net,
       linux-kernel@vger.kernel.org
Subject: Re: Initramfs
References: <200308210044.17876.gkajmowi@tbaytel.net> <1061447419.19503.20.camel@camp4.serpentine.com> <3F44D504.7060909@pobox.com> <20030821193113.A3448@almesberger.net>
In-Reply-To: <20030821193113.A3448@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Jeff Garzik wrote:
> 
>>Support replacing "initrd=" with "initramfs=", so that bootloaders can 
>>pass a cpio image into the standard initrd memory space.
> 
> 
> This sounds like a very good idea, yes.
> 
> Or, maybe even make it such that initramfs acts like a file system,
> that will just de-cpio the content of a block device to a ramfs.


initramfs _must_ act like a file system ;-)

Basically, instead of rd+ext2, you have rootfs.

	Jeff



