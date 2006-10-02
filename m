Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965463AbWJBWA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965463AbWJBWA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 18:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965464AbWJBWA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 18:00:56 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:36737 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965463AbWJBWAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 18:00:55 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH 3/4] 2.6.18-mm2 pktcdvd: restructure code
References: <op.tgratfqriudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Oct 2006 00:00:29 +0200
In-Reply-To: <op.tgratfqriudtyh@master>
Message-ID: <m3odsue5tu.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this patch 3/4 for pktcdvd against Linux 2.6.18 (stable)
> or 2.6.18-mm2 restructures the code for better readability
> and prepares it for the sysfs interface code following in patch 4/4.

This is still kind of hard to review. It would be much better if it
was split in two parts, where the first part only moved existing
functions around, and the second part added other neat things, such as
the pkt_find_dev() and pkt_find_dev_bdev() functions.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
