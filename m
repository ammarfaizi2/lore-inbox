Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWGJOqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWGJOqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWGJOqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:46:08 -0400
Received: from khc.piap.pl ([195.187.100.11]:185 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1422640AbWGJOqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:46:07 -0400
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, Jean Delvare <khali@linux-fr.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>
	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>
	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net>
	<m3y7v14neb.fsf@defiant.localdomain> <44B26439.8070805@gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 10 Jul 2006 16:46:04 +0200
In-Reply-To: <44B26439.8070805@gmail.com> (Antonino A. Daplas's message of "Mon, 10 Jul 2006 22:29:13 +0800")
Message-ID: <m3veq5r00j.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@gmail.com> writes:

> Well if the i2c code happens to depend on another module, I hope
> that Jean would warn us in a timely manner :-).

It doesn't have to be another module. Just another config option.

> And even if Jean
> failed to do so, it would immediately result in a compile
> error/warning which should lead to an easy fix.

The recent events with selecting HDLC for synclink adapters don't
exactly confirm that but I have to say I'm not comfortable with
"depends on" either (because configuring the kernel is harder).

Will try to invent something :-)
-- 
Krzysztof Halasa
