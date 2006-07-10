Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWGJJt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWGJJt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWGJJt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:49:57 -0400
Received: from khc.piap.pl ([195.187.100.11]:15078 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932338AbWGJJt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:49:57 -0400
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 10 Jul 2006 11:49:55 +0200
In-Reply-To: <44B196ED.1070804@pol.net> (Antonino A. Daplas's message of "Mon, 10 Jul 2006 07:53:17 +0800")
Message-ID: <m3irm5hjr0.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@pol.net> writes:

> Why don't you create a separate function for this, ie cirrusfb_create_i2c()
> or something. This way, we eliminate the #ifdef/#endif inside the function.

#ifdef inside a function isn't a problem, while unnecessary complication
(= worse readability) is.
-- 
Krzysztof Halasa
