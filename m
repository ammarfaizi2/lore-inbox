Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265574AbUGDMSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbUGDMSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUGDMSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:18:34 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:9484 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265574AbUGDMSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:18:14 -0400
Date: Sun, 4 Jul 2004 14:18:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ali Akcaagac <aliakc@web.de>
Cc: linux-kernel@vger.kernel.org, linux-msdos@vger.kernel.org
Subject: Re: [BUG] FAT broken in 2.6.7-bk15
Message-ID: <20040704121809.GD6456@pclin040.win.tue.nl>
References: <1088940508.655.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088940508.655.6.camel@localhost>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 01:28:28PM +0200, Ali Akcaagac wrote:

> The recent changes in 2.6.7-bk15 broke FAT support. I am doing some
> rescue backup systems here using tools like syslinux and mtools to
> format a normal msdos disk (for el-torito). I figured out that after
> creating and formating of these disks that it is impossible to mount
> them with 'msdos' or 'vfat'.

You may be able to check for yourself precisely which change caused
trouble for you. The only very recent change is one that makes the
kernel more permissive.

Give details on what versions work for you, what versions don't.
Give the exact error messages. Give the first few sectors of the
filesystem that you cannot mount but can mount with an earlier kernel.

Andries
