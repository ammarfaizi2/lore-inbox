Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422665AbWBAQEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWBAQEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWBAQEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:04:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:12481 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422665AbWBAQEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:04:52 -0500
Date: Wed, 1 Feb 2006 17:04:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Add support for soft scrollback
In-Reply-To: <drn1r9$mtm$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0602011704300.22529@yvahk01.tjqt.qr>
References: <43D492C4.3000801@gmail.com> <drn1r9$mtm$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +
>> +		printk("vgacon delta: %i\n", lines);
>
>                ^^^^^^
>This disables the hard scrollback, as the console is immediately
>scrolled back when the mesage gets printed.
>

printk(KERN_DEBUG ) should probably help it. That way, only syslog picks it 
up.


Jan Engelhardt
-- 
