Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264888AbUEKRAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbUEKRAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbUEKQ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:59:58 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:57249 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264888AbUEKQti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:49:38 -0400
Date: Tue, 11 May 2004 12:44:56 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Bob Tracy <rct@gherkin.frus.com>
cc: Kurt Garloff <garloff@suse.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Format Unit can take many hours
In-Reply-To: <20040511162822.C46BFDBDB@gherkin.frus.com>
Message-ID: <Pine.GSO.4.33.0405111243300.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Bob Tracy wrote:
>Moreover, it simply "feels" wrong to define a constant for something
>that isn't...  The quick fix of increasing the timeout doesn't address
>the underlying issue of how long a format should take, and as Ricky
>implies, that's probably more the concern of the application rather
>than the driver.

The real problem is a lack of being able to specify a timeout for user
supplied commands.  In-kernel drivers can set a command timeout.  The
IOCTL interface does not export that capability.

--Ricky


