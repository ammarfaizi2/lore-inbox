Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWGJLtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWGJLtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWGJLtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:49:23 -0400
Received: from khc.piap.pl ([195.187.100.11]:28840 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751323AbWGJLtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:49:22 -0400
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>
	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 10 Jul 2006 13:49:20 +0200
In-Reply-To: <44B2398B.7040300@pol.net> (Antonino A. Daplas's message of "Mon, 10 Jul 2006 19:27:07 +0800")
Message-ID: <m3ejwt65of.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@pol.net> writes:

>> Feel free to add another patch, while I don't see a need I have nothing
>> against :-)
>
> No, you fix the patch.

Look, I don't feel my patch needs such "fix". So if you think it does,
you have to do it.

> And while your at it, check your Kconfig
> dependencies, ie check for impossible combinations such as CONFIG_I2C=m,
> CONFIG_FB_CIRRUS=y.

You're right here, I don't know why I assumed DEPENDS does it
automatically.
-- 
Krzysztof Halasa
