Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbULaRx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbULaRx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbULaRvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:51:11 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:36872 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262138AbULaRu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:50:56 -0500
Date: Fri, 31 Dec 2004 18:50:51 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: William <wh@designed4u.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Message-ID: <20041231175051.GD2818@pclin040.win.tue.nl>
References: <200412311741.02864.wh@designed4u.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412311741.02864.wh@designed4u.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 05:41:02PM +0000, William wrote:

> Regularly, when attempting to umount() a filesystem I receive 'device is busy' 
> errors. The only way (that I have found) to solve these problems is to go on 
> a journey into processland and kill all the guilty ones that have tied 
> themselves to the filesystem concerned.

Do you know about the existence of the MNT_DETACH flag of umount(2),
or the -l option of umount(8)?

It seems that does at least some of the things you are asking for.

Andries
