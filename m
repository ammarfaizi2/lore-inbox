Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbUK3A2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUK3A2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUK3A2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:28:09 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:42440 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261884AbUK3A2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:28:04 -0500
Subject: Re: Suspend 2 merge: 49/51: Checksumming
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Rob Landley <rob@landley.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411290455.10318.rob@landley.net>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101300589.5805.392.camel@desktop.cunninghams>
	 <200411290455.10318.rob@landley.net>
Content-Type: text/plain
Message-Id: <1101767472.4343.439.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 30 Nov 2004 11:24:37 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-11-29 at 20:55, Rob Landley wrote:
> On Wednesday 24 November 2004 08:02 am, Nigel Cunningham wrote:
> > A plugin for verifying the consistency of an image. Working with kdb, it
> > can look up the locations of variations. There will always be some
> > variations shown, simply because we're touching memory before we get
> > here and as we check the image.
> 
> A while back I suggested checking the last mount time of the mounted local 
> filesystems as a quick and dirty sanity check between loading the image and 
> unfreezing all the processes.  (Since a read-only mount shouldn't touch this, 
> triggering swsusp resume from userspace after prodding various hardware 
> shouldn't cause a major problem either...)  Does that sound like a good idea?

If I recall correctly, someone replied that even a read only mount under
one filesystem (XFS? Not sure), would replay the journal, so it wasn't a
goer.

> Haven't had time to look into it myself, though.  (Just recently got time 
> enough to bang on busybox again.  Somewhere around 2.6.7, software suspend 
> stopped working for me and I haven't even had a chance to track _that_ down 
> yet.  Hopefully fixed in 2.6.9 or 2.6.10, I haven't played with it 
> recently...)

If you mean suspend2, I might be able to help if given more info.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

