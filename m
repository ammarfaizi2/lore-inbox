Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTFZVXC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTFZVXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:23:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36227
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263245AbTFZVW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:22:57 -0400
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Dillow <dave@thedillows.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1056597452.2732.4.camel@ori.thedillows.org>
References: <1056493150.2840.17.camel@ori.thedillows.org>
	 <20030624204828.I30001@newbox.localdomain>
	 <1056513292.3885.2.camel@ori.thedillows.org>
	 <1056557323.1444.4.camel@dhcp22.swansea.linux.org.uk>
	 <1056597452.2732.4.camel@ori.thedillows.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056663251.3172.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jun 2003 22:34:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-26 at 04:17, David Dillow wrote:
> Trace; c01de899 <idescsi_reset+29/80>
> Trace; c01d891d <scsi_reset+11d/370>

Interesting trace.

Lets try a little sanity check first then. Replace that whole 
idescsi_reset handler with "return SCSI_RESET_SNOOZE"

(I think its snooze)


