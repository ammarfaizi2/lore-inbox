Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUEERI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUEERI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUEERI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:08:56 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:64901 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264737AbUEERIy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:08:54 -0400
Subject: Re: [PATCH-RFC] code for raceless /sys/fs/foofs/*
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040505163650.GO17014@parcelfarce.linux.theplanet.co.uk>
References: <16536.61900.721224.492325@laputa.namesys.com>
	 <20040505162802.GN17014@parcelfarce.linux.theplanet.co.uk>
	 <20040505163650.GO17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083776930.3622.45.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 13:08:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-05 at 12:36, viro@parcelfarce.linux.theplanet.co.uk
wrote:

> We also allow anyone with sysfs mounted to see which filesystems are currently
> mounted on the box - again, regardless of being able to see them in the
> chroot jail/restricted namespace/etc.  It can easily become an issue in
> setups where such information is sensitive.

...but are you *really* likely to be mounting sysfs in a chrooted jail
or restricted namespace?

...and if you do, aren't you more likely to simply 'mount --bind' those
minimal parts of sysfs that you actually need for the given process that
is gaoled?

Cheers,
  Trond
