Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUK3NEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUK3NEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUK3NEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:04:11 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:48796 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262062AbUK3NED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:04:03 -0500
Subject: Re: Looking for a single patch file for the ITE8212 kernel
	2.6.10-rc2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mws <mws@twisted-brains.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411291910.53740.mws@twisted-brains.org>
References: <200411291910.53740.mws@twisted-brains.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101816038.25603.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 12:00:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-29 at 18:10, Mws wrote:
> hi,
> 
> does somebody, or you alan, have a single patch to support the ite8212 ide chip?
> i now that it is contained in the latest ac patch - but that is against kernel 2.6.9

The IT8212 driver depends on other -ac IDE changes. There was an earlier
version that didn't but that has some other bugs and since Bartlomiej
rejected it I've no interest in maintaining that version.

I'm afraid you'll need the -ac patches to use the IT8212. That isn't how
I wanted it either. Once 2.6.10 is out I'll maybe do a 2.6.10-ac. Right
now however both the released 10rc trees crashed or hung on boot on my
test boxes and I've not got the time to mess with random -bk snapshots.

Alan

