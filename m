Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTJYC2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 22:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbTJYC2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 22:28:07 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:12978 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262274AbTJYC2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 22:28:04 -0400
Date: Sat, 25 Oct 2003 04:28:03 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4] EDD 4-byte MBR disk signature for the boot disk
Message-ID: <20031025022803.GA18168@DUK2.13thfloor.at>
Mail-Followup-To: Matt Domsch <Matt_Domsch@dell.com>,
	linux-kernel@vger.kernel.org
References: <20031014104508.GA5820@win.tue.nl> <20031014133804.GC15295@iguana.domsch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014133804.GC15295@iguana.domsch.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 08:38:09AM -0500, Matt Domsch wrote:
> >    Can you remind me why you want to retrieve the boot disk?
> 
> Fair question.  Consider the case of automated factory install of a
> new system.  One may configure the system to have multiple disk
> controllers and multiple disks on them, attached in just about any
> way.  One common configuration our customers like is to have two disks
> attached to one controller on which to put the OS, then maybe 8 more
> disks on a second SCSI backplane going to two channels of another
> controller on which they want to build their database files.
> 
> Right now, there's no good way to determine programatically from
> within Linux which disk controller and disk the BIOS will decide is
> the boot device.

hmm, IIRC devfs makes a /dev/root symlink pointing
to the root device ... is this not what you want?

please ignore if I talk nonsense ...

best,
Herbert

