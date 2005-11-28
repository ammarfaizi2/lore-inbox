Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVK1Bm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVK1Bm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 20:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVK1Bm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 20:42:29 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:38691 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751210AbVK1Bm2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 20:42:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NGaDfuTKPXxNYU6JUU0PMYWFG+JErst7rtOKADdYnEYBv2X3r+DlZKPzemLxC0hSS9H+pnJvKWX+QVQbP1vQ+Ts3bEVBwHjLjEXzTlJ/ZPOJLh0iFNmBPSK4HnO35OwjJ2GZy/WfrVLaLZ2Rfaf01Me2ydAD+P+ubbHSwy0rG6Y=
Message-ID: <5bdc1c8b0511271742y75306962h67193b8a0191841d@mail.gmail.com>
Date: Sun, 27 Nov 2005 17:42:28 -0800
From: Mark Knecht <markknecht@gmail.com>
To: gcoady@gmail.com
Subject: Re: umount
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <jdkko1hs90ffvqru9v354vrubggcdrnhhj@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511272154.jARLsBb11446@apps.cwi.nl>
	 <jdkko1hs90ffvqru9v354vrubggcdrnhhj@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
>
> It leaves me with a little distrust of linux' handling of non-locked
> removable media (as opposed to lockable media like a zipdisk or cdrom).
>
> Grant.

Under Windows, if a 1394 drive is unplugged without unmounting, it you
get a pop up dialog on screen telling you that data may be lost, etc.
while under any of the main environments I've tried under Linux
(Gnome, KDE, fluxbox) there are no such messages to the user. I have
not investigated log files very deeply, other than to say that dmesg
will show the drive going away but doesn't say it was a problem.

I realize it's probably 100x more difficult to do this under Linux, at
least at the gui level, but I agree with your main point that my trust
factor is just a bit lower here.

- Mark
