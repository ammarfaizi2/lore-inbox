Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVBPS2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVBPS2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 13:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVBPS2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 13:28:13 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:61898 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262085AbVBPSXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 13:23:19 -0500
Date: Wed, 16 Feb 2005 19:19:49 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: a.hocquel@oreka.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange bug with realtek 8169 card
Message-ID: <20050216181949.GA17159@electric-eye.fr.zoreil.com>
References: <3xSPL-6F2-55@gated-at.bofh.it> <3y6g1-KN-23@gated-at.bofh.it> <42138AA5.3040506@oreka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42138AA5.3040506@oreka.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre <a.hocquel_NOSPAM_@oreka.com> :
[...]
> Any other idea ?

Please try:
http://www.fr.zoreil.com/~francois/misc/20050202-2.4.29-r8169.c-test.patch

Compile with gcc-3.x and send/publish _complete_ dmesg + lspci -vx +
cat /proc/interrupts + ifconfig if it still hangs.

--
Ueimor
