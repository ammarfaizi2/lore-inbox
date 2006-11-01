Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946266AbWKABsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946266AbWKABsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946295AbWKABsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:48:42 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:30987 "EHLO
	asav13.insightbb.com") by vger.kernel.org with ESMTP
	id S1946266AbWKABsl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:48:41 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAK6KR0VKhRUUXWdsb2JhbACMPyw
From: Dmitry Torokhov <dtor@insightbb.com>
To: =?iso-8859-1?q?J=F6rg_Hundertmarck?= <joerg@hundertmarck.de>
Subject: Re: Simple extension to psmouse driver (tp-scroll in kernel mode)
Date: Tue, 31 Oct 2006 20:48:38 -0500
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200610312228.21804.joerg@hundertmarck.de>
In-Reply-To: <200610312228.21804.joerg@hundertmarck.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610312048.38749.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 16:28, Jörg Hundertmarck wrote:
> Hello world,
> 
> I've wrote a simple extension to the psmouse driver. It's an emulation for the
> scrolling wheel on TrackPoint mice. It's functionally the same like the userspace
> daemon tp-scroll but it doesn't lag if the system has full load. The emulation
> starts when you press the middle mouse button, then you can "scroll" up and
> down by moving the mouse into the desired direction. It stops when the button
> released. When you press and release the button without move, the button event
> is transfered. This feature is not enabled by default, you need to set
> CONFIG_MOUSE_TPWHEEL=y.
> 
> Here's the patch:
> http://www.hirnfrei.org/~joerg/linux_patches/linux-2.6.17-gentoo-r7-tp-scroll.patch
> 
> The patch is tested against the the 2.6.17 and 2.6.18.1 kernel source.
> 
> I hope that's the correct mailing list and my code is usefull.
>

Hi,

Thank you for your patch, however I do not think it is needed anymore
since required functionality was added to X. Please see here:

http://www.thinkwiki.org/wiki/How_to_configure_the_TrackPoint
http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/2006-January/031714.html
 
-- 
Dmitry
