Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbVIHPrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbVIHPrV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVIHPrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:47:20 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:8809
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932620AbVIHPrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:47:19 -0400
Message-Id: <4320796402000078000244DC@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:48:20 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmmod notifier chain
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com> <20050908153314.GM3966@smtp.west.cox.net>
In-Reply-To: <20050908153314.GM3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It's possible to do this a bit differently, if I'm guessing right at
>what NLKD does.  The following is from the KGDB patches (trimmed of
some
>other, unrelated to the notify part code):

Hmm, yes, this seems to be the better way to go.

Thanks, Jan
