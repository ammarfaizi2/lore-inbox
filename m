Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUK1MgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUK1MgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 07:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUK1MgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 07:36:22 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:36834 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261453AbUK1MgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 07:36:21 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
CC: ecki-news2004-05@lina.inka.de, linux-kernel@vger.kernel.org
In-reply-to: <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Sun, 28 Nov 2004 12:18:00 +0000)
Subject: Re: Problem with ioctl command TCGETS
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1CYODw-0001jf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 28 Nov 2004 13:32:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Think read(2)/write(2).  We already have several barfbags too many,
> and that includes both ioctl() and setsockopt().  We are stuck with
> them for compatibility reasons, but why the hell would we need yet
> another one?

You can't replace either ioctl() or setsockopt() with read/write can
you?  Both of them set out-of-band information on file descriptors.

Proc maybe ('/proc/PID/fdparam/FD/param')?  I'm sure some people would
have objections to that too. 

Miklos
