Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUK1Sqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUK1Sqe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUK1Sqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:46:33 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:14482 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261563AbUK1Sq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:46:27 -0500
Subject: Re: Problem with ioctl command TCGETS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ecki-news2004-05@lina.inka.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk>
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net>
	 <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu>
	 <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101663767.16761.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 28 Nov 2004 17:42:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-28 at 12:18, Al Viro wrote:
> Think read(2)/write(2).  We already have several barfbags too many,
> and that includes both ioctl() and setsockopt().  We are stuck with
> them for compatibility reasons, but why the hell would we need yet
> another one?

Synchronization.

