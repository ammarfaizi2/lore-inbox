Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267896AbUGaCEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267896AbUGaCEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 22:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267895AbUGaCEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 22:04:55 -0400
Received: from mail.zmailer.org ([62.78.96.67]:53694 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S267896AbUGaCEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 22:04:53 -0400
Date: Sat, 31 Jul 2004 05:04:48 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: sankarshana rao <san_wipro@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: storing a Filesystem in a file
Message-ID: <20040731020448.GG2429@mea-ext.zmailer.org>
References: <20040731014626.72400.qmail@web50903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731014626.72400.qmail@web50903.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 06:46:26PM -0700, sankarshana rao wrote:
> Hi,
> I have a requirement to create a file system in a file
> . Is this possible???

Like previous responder said, copying a device content (partition,
or whole device full) to a file is trivialish.

If you want to create a filesystem (like e.g. ramdisk-images are
created when builing kernel installation), then you do need a device
called 'loop'.  See 'man losetup'.

> thx in advance...

/Matti
