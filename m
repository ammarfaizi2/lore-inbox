Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTHUOUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbTHUOUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:20:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18629 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262680AbTHUOUG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:20:06 -0400
Message-ID: <3F44D504.7060909@pobox.com>
Date: Thu, 21 Aug 2003 10:19:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@serpentine.com>
CC: gkajmowi@tbaytel.net, linux-kernel@vger.kernel.org
Subject: Re: Initramfs
References: <200308210044.17876.gkajmowi@tbaytel.net> <1061447419.19503.20.camel@camp4.serpentine.com>
In-Reply-To: <1061447419.19503.20.camel@camp4.serpentine.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:
> No.  initramfs is stuck in limbo at the moment, and early userspace is
> unlikely to see any real work until 2.7.  Feel free to ask questions,
> but don't expect them to result in anything actually happening.
> 
> If you want to do real work in this area, the klibc mailing list is the
> place to go: http://www.zytor.com/mailman/listinfo/klibc


Correct, though there is one thing I am thinking about adding to 2.6:

Support replacing "initrd=" with "initramfs=", so that bootloaders can 
pass a cpio image into the standard initrd memory space.

	Jeff



