Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270659AbTHEUgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270673AbTHEUgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:36:50 -0400
Received: from codepoet.org ([166.70.99.138]:64657 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270659AbTHEUgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:36:49 -0400
Date: Tue, 5 Aug 2003 14:36:49 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Mitch@0Bits.COM
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
Message-ID: <20030805203649.GA9982@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Mitch@0Bits.COM, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0308052032220.31114@mx.homelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308052032220.31114@mx.homelinux.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 05, 2003 at 08:37:38PM +0100, Mitch@0Bits.COM wrote:
> 
> Works fine with XFree86 4.3.x, 2.4.22-pre10 and the radeon.o
> drm module. If you look backwards in your strace file, what is the
> device that file descriptor 5 belongs to ?

I have XFree86 4.2.1 (i.e. xfree86-common, xserver-xfree86,
xlibmesa3-gl, etc) version 4.2.1-9 from Debian unstable installed.

I think you mean file descriptor 4:
    open("/dev/dri/card0", O_RDWR)          = 4

$ ls -la /dev/dri/card0
crw-rw-rw-    1 root     root     226,   0 Jul 12 04:21 /dev/dri/card0

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
