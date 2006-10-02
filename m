Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965464AbWJBWC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965464AbWJBWC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 18:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965465AbWJBWC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 18:02:27 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:51350 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965464AbWJBWC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 18:02:26 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH 4/4] 2.6.18-mm2 pktcdvd: sysfs + debugfs interface, bio write congestion handling
References: <op.tgraunhniudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Oct 2006 00:01:58 +0200
In-Reply-To: <op.tgraunhniudtyh@master>
Message-ID: <m3k63ie5rd.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this patch 4/4 for pktcdvd against Linux 2.6.18 (stable)
> or 2.6.18-mm2 adds a sysfs and a debugfs interface. Also it adds
> the ability to control the bio write queue of the driver (write
> congestion control).
> For more infos see the Documentation/* files in the patch.

The sysfs interface makes sense even without the congestion control,
so the two features should be two separate patches.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
