Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUBHVzx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 16:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUBHVzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 16:55:52 -0500
Received: from slask.tomt.net ([217.8.136.223]:31365 "EHLO pelle.tomt.net")
	by vger.kernel.org with ESMTP id S264129AbUBHVzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 16:55:51 -0500
Message-ID: <4026B064.5080900@tomt.net>
Date: Sun, 08 Feb 2004 22:55:48 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc1
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <200402071722.10242.bzolnier@elka.pw.edu.pl> <4025D0F2.1020400@tomt.net> <200402082234.22043.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402082234.22043.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Do you load any other IDE host modules before pdc202xx_old?

Yes, pdc202xx_new

_old is for the onboard pdc, and _new for the just installed TX-2.

it also tries to load hpt34x and hpt366 first, but the machine does not 
have any hpt hardware in it, so it shouldn't matter.

  >>Unable to handle kernel virtual paging request at virtual address 
24748b24
>>
>>EIP is at ide_pci_register_host_proc+0x27/0x40 [ide_core]
> 
> 
> Can you disassemble ide_pci_register_host_proc using gdb?

I'd need a walkthrough, not very familiar with gdb other than getting a 
backtrace out of it

The kernel is compiled with gcc version 3.3.2 in Debian Sarge/Testing.
