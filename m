Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTFYB2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTFYB2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:28:18 -0400
Received: from [63.98.246.130] ([63.98.246.130]:4267 "EHLO
	mailgw.projectdesign.com") by vger.kernel.org with ESMTP
	id S264242AbTFYB2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:28:16 -0400
Subject: Re: Intel RAID hw card
From: Joshua Penix <jpenix@binarytribe.com>
To: linux-kernel@vger.kernel.org
Cc: ertra@volny.cz
In-Reply-To: <008901c33a9e$492aa080$c15af53e@dev>
References: <008901c33a9e$492aa080$c15af53e@dev>
Content-Type: text/plain
Message-Id: <1056505345.11051.18.camel@jepdesk.projectdesign.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 24 Jun 2003 18:42:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 15:16, tomas wrote:

> Intel Server RAID Controller U3-1LA (SRCU31LA)
> 
> please, could somebody tell me if I can use linux (Redhat 9 for example)
> with this hw RAID card for raid 1 without problems ?

I'm using an Intel SRCMR RAID controller in RAID5 mode under RedHat 9
with 280GB attatched and have no trouble at all.  From what I can tell
on Intel's website, my card and yours both use the same "GDTH" kernel
driver, so I don't see any reason why yours won't work... unless your
RAID controller model is newer (but it shouldn't be, I see specs on your
model dating back to 2002) and the kernel just doesn't recognize its PCI
ID yet.

HTH,
--Josh

