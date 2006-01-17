Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWAQMxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWAQMxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWAQMxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:53:20 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:24496 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932467AbWAQMxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:53:19 -0500
To: hch@infradead.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
In-reply-to: <20060117124707.GA8004@infradead.org> (message from Christoph
	Hellwig on Tue, 17 Jan 2006 12:47:07 +0000)
Subject: Re: [PATCH 01/17] add /sys/fs
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu> <20060114004028.711485000@dorka.pomaz.szeredi.hu> <20060117124707.GA8004@infradead.org>
Message-Id: <E1EyqKE-0005c9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Jan 2006 13:52:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch adds an empty /sys/fs, which filesystems can use.
> 
> How does this address all the comments on the last submission
> (as part of the reiser4 core changes)?

It's a different patch.

This just adds /sys/fs without any content.  Fuse needs this to add
some stuff, and other fs can use it as needed.

Miklos

