Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268996AbRH0VMC>; Mon, 27 Aug 2001 17:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268970AbRH0VLx>; Mon, 27 Aug 2001 17:11:53 -0400
Received: from [194.213.32.141] ([194.213.32.141]:52740 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S268963AbRH0VLr>;
	Mon, 27 Aug 2001 17:11:47 -0400
Message-ID: <20010827231126.A21664@bug.ucw.cz>
Date: Mon, 27 Aug 2001 23:11:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: v4l interface questions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have few questions about v4l api.

I have device (vicam == usb 3com homeconnect camera), which would like to
fit into v4l framework. But... mmap is not really native operation for
usb. Should I emulate it, or just return unsupported and expect
applications to use read()?

Similar problem is there with formats. vicam has some really strange
formats. Should I do conversion in kernel?

Is there some usermode program that can handle camera without mmap
ability and can support arbitrary screen sizes + 16bpp grayscale?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
