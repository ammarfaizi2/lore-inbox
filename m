Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423692AbWKHUsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423692AbWKHUsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423694AbWKHUsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:48:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24704 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423692AbWKHUsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:48:19 -0500
Subject: Re: [PATCH] HZ: 300Hz support
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1163018557.23956.92.camel@localhost.localdomain>
References: <1163018557.23956.92.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 21:48:17 +0100
Message-Id: <1163018898.3138.388.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 20:42 +0000, Alan Cox wrote:
> Fix two things. Firstly the unit is "Hz" not "HZ". Secondly it is useful
> to have 300Hz support when doing multimedia work. 250 is fine for us in
> Europe but the US frame rate is 30fps (29.99 blah for pedants). 300
> gives us a tick divisible by both 25 and 30, and for interlace work 50
> and 60. It's also giving similar performance to 250Hz.
> 
> I'd argue we should remove 250 and add 300, but that might be excess
> disruption for now.


the last time 300 was proposed the counter argument was that it was
lousy in terms of PIT rounding... did you check that out?


