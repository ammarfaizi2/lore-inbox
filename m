Return-Path: <linux-kernel-owner+w=401wt.eu-S932666AbXALLA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbXALLA1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbXALLA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:00:27 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:57159 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932666AbXALLA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:00:27 -0500
Date: Fri, 12 Jan 2007 11:59:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: congwen <congwen@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How can I create or read/write a file in linux device driver?
In-Reply-To: <9a8748490701120254x6a7dd93aw9dd75994af661f5e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0701121158460.17236@yvahk01.tjqt.qr>
References: <200701121547221465420@gmail.com> 
 <9a8748490701120227h757d473ctaf5673aa318fe090@mail.gmail.com> 
 <Pine.LNX.4.61.0701121139010.17236@yvahk01.tjqt.qr>
 <9a8748490701120254x6a7dd93aw9dd75994af661f5e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 12 2007 11:54, Jesper Juhl wrote:
>> 
>> The article does it the bad way. IMHO filp_open() and
>> vfs_read/vfs_write() are much less problematic wrt. to userspace.
>> FWIW see
>> ftp://ftp-1.gwdg.de/pub/linux/misc/suser-jengelh/kernel/quad_dsp-1.5.1.tar.bz2
>
> There is no good way.  You simply should NOT do it.

I never said there is a good way, just that some are better than others ;-)
As for quad_dsp, well, the reason why it's done in kernel-space is because
userspace wrapping with LD_PRELOAD does not always work, esp. with statically
compiled apps.


	-`J'
-- 
