Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbULGIXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbULGIXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 03:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbULGIXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 03:23:14 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:29836 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261621AbULGIXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 03:23:11 -0500
Date: Tue, 7 Dec 2004 09:21:06 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Lenar =?unknown-8bit?Q?L=C3=B5hmus?= <lenar@vision.ee>
Cc: Johan <johan@ccs.neu.edu>, linux-kernel@vger.kernel.org
Subject: Re: status of via velocity in 2.6.9
Message-ID: <20041207082106.GA24306@electric-eye.fr.zoreil.com>
References: <41B4F447.2060808@ccs.neu.edu> <41B56518.2070108@vision.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41B56518.2070108@vision.ee>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lenar Lõhmus <lenar@vision.ee> :
[...]
> the machine just locked up after ifconfig up. With 2.6.9, it doesn't 
> lock up, but it doesn't work either (data seems to go to black hole
> or sth). But there seem to be some success reports too with this kernel.

Can you check if the computer hosts the latest bios from its vendor and
if booting with "acpi=off" makes a difference ?

The content of /proc/interrupts after a known number of TX packets could
give some hint (use ping or such and correlate ifconfig output with
/proc/interrupts).

Please direct/Cc: further messages to netdev@oss.sgi.com.

--
Ueimor
