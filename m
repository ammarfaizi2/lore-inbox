Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWFYLgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWFYLgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWFYLgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:36:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932379AbWFYLge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:36:34 -0400
Date: Sun, 25 Jun 2006 04:36:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Christian Lohmaier <lohmaier@gmx.de>
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read
 atip wiith cdrecord
Message-Id: <20060625043622.e42c7254.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0606251304450.28911@yvahk01.tjqt.qr>
References: <200606242036.k5OKaSvp031813@fire-2.osdl.org>
	<20060624144739.78bde590.akpm@osdl.org>
	<Pine.LNX.4.61.0606251304450.28911@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 13:05:59 +0200 (MEST)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >>            Summary: kernel hangs when trying to read atip wiith cdrecord
> >>     Kernel Version: 2.6.16.1
> 
> >> Most recent kernel where this bug did not occur: 2.6.16.1 (yes, the 
> >> same version - it works with my dvd-burner, but not with my cd-burner), 
> >> the 2.4 series worked with both, but there I have been using ide-scsi)
> 
> Can you try a newer version and/or (or both) with an original cdrecord (if 
> not already done so) or cdrecord-prodvd?
> 
> >> Distribution: Mandriva 9.0 based
> 
> >> cdrtools 2.01.01a10
> 
> >> Steps to reproduce:
> >> I simply try to use "cdrecord dev=ATAPI:1,0,0 -atip" as root.
> >> # cdrecord dev=ATAPI:1,0,0 -atip
> 
> Try -dev=/dev/hdX
> 

[added Christian (the bug reporter) to cc]
