Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUBMO1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267002AbUBMO1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:27:24 -0500
Received: from mail.shareable.org ([81.29.64.88]:44418 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266831AbUBMO1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:27:23 -0500
Date: Fri, 13 Feb 2004 14:27:19 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Daniel Blueman <daniel.blueman@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
Message-ID: <20040213142719.GA28100@mail.shareable.org>
References: <9792.1076675029@www11.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9792.1076675029@www11.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Blueman wrote:
> many modern IDE disks and
> controllers also have tagged command queuing, so it is even more of a corner case.

Linux doesn't use tagged command queueing, though - the code has been
disabled for some time.  I thought the TCQ stuff was disabled because
only very few disks supported it and the code wasn't reliable.

Yet you say many modern disks support it?

-- Jamie
