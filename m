Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWJWLG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWJWLG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWJWLG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:06:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50831 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751899AbWJWLGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:06:55 -0400
Subject: Re: make pdfdocs broken in 2.6.19rc2 and needs fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
In-Reply-To: <200610222347.42418.ak@suse.de>
References: <200610222347.42418.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Oct 2006 12:09:39 +0100
Message-Id: <1161601779.19388.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-22 am 23:47 +0200, ysgrifennodd Andi Kleen:
> When you do make pdfdocs  with 2.6.19rc2-git7 you get tons of error 
> messages and  then some corrupted PDFs in the end.

Some vendor shipped pdf and TeX tools are problematic. It works
correctly on Red Hat except for kernel-api which has become too big for
the default settings when ext4 was added. The TeX hash size gets
exceeded, TeX emits

"! TeX capacity exceeded, sorry [hash size=60000].
If you really absolutely need more capacity,
you can ask a wizard to enlarge me."


Really it would be nice to find a more modern way from the input to pdf
without going via tex.

