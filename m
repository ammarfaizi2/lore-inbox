Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbULCJ1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbULCJ1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbULCJ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:27:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:2781 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262113AbULCJ1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:27:18 -0500
Date: Fri, 3 Dec 2004 01:26:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041203012645.21377669.akpm@osdl.org>
In-Reply-To: <41B02DFD.9090503@gmx.de>
References: <20041202130457.GC10458@suse.de>
	<20041202134801.GE10458@suse.de>
	<20041202114836.6b2e8d3f.akpm@osdl.org>
	<20041202195232.GA26695@suse.de>
	<20041202121938.12a9e5e0.akpm@osdl.org>
	<41AF94B8.8030202@gmx.de>
	<20041203070108.GA10492@suse.de>
	<41B02DFD.9090503@gmx.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
>
> > Can you try with the patch that is in the parent of this thread? The
>  > above doesn't look that bad, although read performance could be better
>  > of course. But try with the patch please, I'm sure it should help you
>  > quite a lot.
>  > 
> 
>  It actually got worse: Though the read rate seems accepteble, it is not, as 
>  interactivity is dead while writing.

Is this a parallel IDE system?  SATA?  SCSI?  If the latter, what driver
and what is the TCQ depth?

