Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbUKBRF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbUKBRF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbUKBRFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:05:19 -0500
Received: from zamok.crans.org ([138.231.136.6]:11676 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261885AbUKBRDq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 12:03:46 -0500
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, jfannin1@columbus.rr.com, agk@redhat.com,
       christophe@saout.de, linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
References: <20041026123651.GA2987@zion.rivenstone.net>
	<20041026135955.GA9937@agk.surrey.redhat.com>
	<20041026213703.GA6174@rivenstone.net>
	<20041026151559.041088f1.akpm@osdl.org>
	<87hdogvku7.fsf@barad-dur.crans.org>
	<20041026222650.596eddd8.akpm@osdl.org>
	<20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de>
	<877jpcgolt.fsf@barad-dur.crans.org> <20041102143919.GT6821@suse.de>
	<20041102145541.GV6821@suse.de>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 02 Nov 2004 18:03:44 +0100
In-Reply-To: <20041102145541.GV6821@suse.de> (Jens Axboe's message of "Tue, 2
	Nov 2004 15:55:41 +0100")
Message-ID: <87acu0p4i7.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> disait dernièrement que :

> Ehm, that should be
>
> 		if ((isize - offset))
> 			bytes_todo = isize - offset;
> 		else if (bytes_todo > PAGE_SIZE)
> 			bytes_todo = PAGE_SIZE;
>

this one works :)
(of course on top 2.6.10-rc1-mm2, too)

Thanks,

-- 
<JALH> regex are more than some crappy posix thing
<JALH> they are an art form

	- Marc Zealey on #kernelnewbies

