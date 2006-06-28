Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423258AbWF1KcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423258AbWF1KcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423267AbWF1KcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:32:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58774 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423266AbWF1KcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:32:09 -0400
Subject: RE: [PATCH] ia64: change usermode HZ to 250
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <1151484210.3153.10.camel@laptopd505.fenrus.org>
References: <617E1C2C70743745A92448908E030B2A27F855@scsmsx411.amr.corp.intel.com>
	 <1151484210.3153.10.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jun 2006 11:47:57 +0100
Message-Id: <1151491677.15166.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-28 am 10:43 +0200, ysgrifennodd Arjan van de Ven:
> I would hope not; it's a pretty big regression for the telco space
> (which really wants 1 or 2 msec delays) so I hope/assume all the
> enterprise distributions (which ia64 specially cares about) stick to the
> old 1024 value...

250 is also really bad for multimedia people. They would much rather
have 300 than 250 as it divides nicely by 50 and by 60 for frame rates.


