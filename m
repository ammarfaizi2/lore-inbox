Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWH3RCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWH3RCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWH3RCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:02:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:24458 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751160AbWH3RCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:02:16 -0400
From: Andi Kleen <ak@suse.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: [PATCH][RFC] exception processing in early boot
Date: Wed, 30 Aug 2006 19:02:20 +0200
User-Agent: KMail/1.9.3
Cc: pageexec@freemail.hu, "Willy Tarreau" <w@1wt.eu>, Riley@williams.name,
       davej@redhat.com, linux-kernel@vger.kernel.org
References: <20060830063932.GB289@1wt.eu> <200608301830.40994.ak@suse.de> <Pine.LNX.4.61.0608301251570.13282@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0608301251570.13282@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301902.20728.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Even the i286 and the 8086 support hlt. Is there some Cyrix chip that
> you are trying to preserve? I think even those all implimented
> hlt as well.


According to the kernel code it's

char    hlt_works_ok;   /* Problems on some 486Dx4's and old 386's */

I don't know more details about what these problems were.

-Andi

