Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269679AbUJMMEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269679AbUJMMEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 08:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269682AbUJMMEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 08:04:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:1736 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269679AbUJMMEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 08:04:24 -0400
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since
	2.6.8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Geng <linux@MichaelGeng.de>
Cc: Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041011162153.GA9101@t-online.de>
References: <20041007165410.GA2306@t-online.de>
	 <20041008105219.GA24842@bytesex> <20041008140056.72b177d9.akpm@osdl.org>
	 <20041009092801.GC3482@bytesex> <20041009112839.GA2908@t-online.de>
	 <20041009121845.GE3482@bytesex> <20041010085541.GA1642@t-online.de>
	 <20041011151455.GC23632@bytesex>  <20041011162153.GA9101@t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097665248.4421.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Oct 2004 12:00:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-10-11 at 17:21, Michael Geng wrote:
> Thank you! Andrew, could you please forward the patch? 
> Suggestion for a comment line:
> Videotext: IOCTLs changed to match _IO macros in linux/ioctl.h

But have any of them changed ioctl number in the process and broken
compatibility ?

