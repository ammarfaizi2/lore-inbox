Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVBOXTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVBOXTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVBOXTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:19:05 -0500
Received: from mail.tyan.com ([66.122.195.4]:61970 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261943AbVBOXSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:18:42 -0500
Message-ID: <3174569B9743D511922F00A0C943142308085872@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: X86_64 kernel support MAX memory.
Date: Tue, 15 Feb 2005 15:32:14 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

I will test 64G on node 4-7 only or 64G on node 0-3.

YH

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Tuesday, February 15, 2005 2:55 PM
> To: YhLu
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: X86_64 kernel support MAX memory.
> 
> On Tue, Feb 15, 2005 at 02:57:14PM -0800, YhLu wrote:
> > It passed the memtest86+ 3.1a
> 
> Are you sure it even tests the full 128GB? Traditionally PAE 
> only supports 64GB. 
> 
> > 
> > No oops dump, it just restart the system.
> 
> At what point exactly? You probably have a serial console. 
> What are the last lines.
> 
> That could well be an ECC error. You can see if mcelog logs 
> something after reboot (kernel should preserve machine check events) 
> 
> Or you could switch around the DIMMs of the CPUs for testing.
> 
> -Andi
> 
