Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264948AbRGACl5>; Sat, 30 Jun 2001 22:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264949AbRGAClr>; Sat, 30 Jun 2001 22:41:47 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:32266 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264948AbRGAClg>; Sat, 30 Jun 2001 22:41:36 -0400
Date: Sat, 30 Jun 2001 22:41:36 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107010241.f612fa209443@devserv.devel.redhat.com>
To: guthrie@home.martnet.com, linux-kernel@vger.kernel.org
Subject: Re: unable to read from IDE tape
In-Reply-To: <mailman.993932281.2803.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.993932281.2803.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lately, I have been having problems reading from from my HP Colorado IDE
> tape drive.  I can use mt to get the status of the drive and to forward the
> drive to a different file.  I can even use tar to write to the tape.
> But whenever I try to read the tar files that I have written to tape, I
> get an I/O error, and there doesn't even seem to be any attempt by the
> driver to read the tape.  This is currently happening under 2.4.5, and
> has been happening undeer at least 2.4.2 and 2.4.3, I think it was also
> happening under 2.4.1 as well.
>[...]
> Any thoughts on what might be wrong?

No good thoughts, the driver is simply horrible...
You might be able to pick some interesting info by
running with tape->debug_level set to 4 (There is an option,
but I forget what. Just assign 4 to it after
a call to idetape_add_settings. Be prepared for a lots of
tracing.

If you come up with any patches, post them to the list.

-- Pete
