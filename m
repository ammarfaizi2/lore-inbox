Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTDWXBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTDWXBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:01:48 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:6419 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264303AbTDWXBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:01:47 -0400
Date: Thu, 24 Apr 2003 01:13:53 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       alan@lxorguk.ukuu.org.uk, andre@linux-ide.org, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (0/4)
Message-ID: <20030423231353.GA21346@win.tue.nl>
References: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl> <20030423153500.0d99b4d3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423153500.0d99b4d3.akpm@digeo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 03:35:00PM -0700, Andrew Morton wrote:

> What is special about the IDE ioctl approach?

Usually one wants to use the standard commands for I/O.
But if the purpose is to talk to the drive (set password,
set native max, eject, change ZIP drive from big floppy
mode to removable disk mode, etc. etc.) then one needs
a means to execute IDE commands "by hand".

Also SCSI has an ioctl for "do command by hand".

Andries

