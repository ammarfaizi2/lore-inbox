Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWAEPrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWAEPrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWAEPrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:47:01 -0500
Received: from canuck.infradead.org ([205.233.218.70]:31408 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751421AbWAEPrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:47:00 -0500
Subject: Re: [PATCH 0/15] Ubuntu patch sync
From: David Woodhouse <dwmw2@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1136414740.4430.44.camel@grayson>
References: <0ISL003P992UCY@a34-mta01.direcway.com>
	 <20060104140627.1e89c185@dxpl.pdx.osdl.net>
	 <1136412768.4430.28.camel@grayson>
	 <20060104143023.5b2f7967@dxpl.pdx.osdl.net>
	 <1136414740.4430.44.camel@grayson>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 15:46:50 +0000
Message-Id: <1136476010.4158.196.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 17:45 -0500, Ben Collins wrote:
> After dealing with literally dozens of upstream drivers, I think the
> reasons boil down to a few categories:

> <...>

You missed one:

5 - They've implemented Yet Another IEEE802.11 stack instead of
embracing and extending the Intel one we already have, and are hence
urinating into the atmospheric disturbance.

That's one of the reasons why I merged bcm43xx and softmac into the
Fedora kernel and none of the others, FWIW -- Johannes is actually
working on improving what we have in the kernel, rather than just saying
"You have to throw it all away because $MYSTACK is better". So I figure
softmac has a _much_ better chance of going upstream, even if its
feature list isn't quite as comprehensive yet.

http://softmac.sipsolutions.net/softmac-2.6.git

-- 
dwmw2

