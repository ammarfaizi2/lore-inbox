Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965444AbWJBVzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965444AbWJBVzf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965441AbWJBVzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:55:35 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:60856 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965444AbWJBVze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:55:34 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH 2/4] 2.6.18-mm2 pktcdvd: make procfs interface optional
References: <op.tgrasbjeiudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Oct 2006 23:55:06 +0200
In-Reply-To: <op.tgrasbjeiudtyh@master>
Message-ID: <m3sli6e62t.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this patch 2/4 for pktcdvd against Linux 2.6.18 (stable)
> or 2.6.18-mm2 makes the procfs interface optional. A new kernel
> config parameter is added: CDROM_PKTCDVD_PROCINTF
> (Of course, you can not use pktcdvd if there is no procfs
> interface. Wait for patch 4/4 that adds the sysfs interface ;)

This comment indicates that the patch ordering is wrong. It doesn't
make much sense to turn off the procfs interface when doing so makes
the driver totally unusable.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
