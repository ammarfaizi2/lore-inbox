Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUF3S4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUF3S4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUF3S4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:56:32 -0400
Received: from mail3.iserv.net ([204.177.184.153]:48276 "EHLO mail3.iserv.net")
	by vger.kernel.org with ESMTP id S266796AbUF3S4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:56:20 -0400
Message-ID: <40E30CE0.70005@didntduck.org>
Date: Wed, 30 Jun 2004 14:56:32 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua <jhudson@cyberspace.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore floppy boot image
References: <Pine.SUN.3.96.1040630143510.23723A-100000@grex.cyberspace.org>
In-Reply-To: <Pine.SUN.3.96.1040630143510.23723A-100000@grex.cyberspace.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua wrote:
> After installing the 2.6.7 kernel a week ago, I had LILO problems
> (lilo bombed on the kernel image). My first thought was to dd the kernel
> to a floppy, and boot Windows so that I could get a new LILO (I have
> a winmodem for dialup). My second thought was better check w/ hexdump
> first.
> 
> I saw that "booting from floppy is no longer supported" message, and
> thought "This won't do.
> 
> Rather than go back to the old version, I thought that I could do it
> better.  Maybe I did and maybe I didn't, but this time the bzImage loading
> code fits into a single sector (no more need of bootsect_kludge).
> 
> Patch-signed-off-by: Joshua Hudson <jhudson@cyberspace.org>
> 

Direct floppy booting was removed for good reasons: it was broken in 
many setups and is easily replaced by syslinux.  See make bzdisk.

--
				Brian Gerst
