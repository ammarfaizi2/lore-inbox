Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUBHLYH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 06:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUBHLYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 06:24:07 -0500
Received: from main.gmane.org ([80.91.224.249]:29579 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263424AbUBHLYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 06:24:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: USB 2.0 mass storage problem
Date: Sun, 08 Feb 2004 12:24:00 +0100
Message-ID: <yw1xr7x5u84v.fsf@kth.se>
References: <200402080610.i186AEp19152@mailgate01.ctimail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-1862.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:cv1X+ufbZV1yO5Fv5cFT7s2JuAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Francis, Chong Chan Fai" <francis.ccf@polyu.edu.hk> writes:

> Hi,
>
> I have my laptop installed with Fedora Core (Kernel 2.4.22), and I want to
> use a USB 2.0 120G hard drive via a Cardbus USB2.0 adaptor.
> I plug the Cardbus card, and then the USB2.0 HD, (after a few config) linux
> recognize my HD and I can use mount /dev/sda1 /mnt/extra to mount it.
>
> HOWEVER, the disk fail after a few read or write operation.

[...]

> The same hardware work perfectly in Windows 2000, It works too when I
> connect the USB to a USB1.0 port in my machine, so I'm quite sure it is the
> problem with the ehci-hcd driver.

This looks like the drive is using a buggy Genesys USB-to-IDE bridge.
Run lsusb and check.  There was a workaround kernel patch floating
around here about a month ago.

-- 
Måns Rullgård
mru@kth.se

