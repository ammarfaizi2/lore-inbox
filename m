Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbTDWHAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 03:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTDWHAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 03:00:09 -0400
Received: from rth.ninka.net ([216.101.162.244]:21420 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263970AbTDWHAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 03:00:08 -0400
Subject: Re: [PATCH] use __GFP_REPEAT in pmd_alloc_one()
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0304221033150.15088-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0304221033150.15088-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051081930.11999.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 00:12:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 02:46, Geert Uytterhoeven wrote:
> If this change was bogus (cfr. Davem's checkin):
...
> Then this one is bogus, too:

I don't think so, I believe Andrew was just trying to trap cases he
didn't understand.

-- 
David S. Miller <davem@redhat.com>
