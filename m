Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265949AbVBDQFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265949AbVBDQFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbVBDQFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:05:19 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:20442 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264698AbVBDQFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:05:10 -0500
Subject: Re: Please open sysfs symbols to proprietary modules
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Roskin <proski@gnu.org>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
	 <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net>
	 <20050202232909.GA14607@kroah.com>
	 <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Feb 2005 16:05:06 +0000
Message-Id: <1107533106.18239.93.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 19:07 -0500, Pavel Roskin wrote:
> There will be a GPL'd layer, and it's likely that sysfs interaction will 
> be on the GPL'd side anyway, for purely technical reasons. 

Be very careful if distributing your driver in two parts -- a GPL'd part
and a part which you claim is not affected by the GPL.

If your non-GPL'd section is an independent and separate work in itself,
then the GPL doesn't apply to it when it is distributed as a separate
work.

But if you distribute that same section as part of a whole which _is_
based on the kernel, then the distribution of the whole must be on the
terms of the GPL. The GPL extends to the entire whole; to each and every
part regardless of who wrote it.

The intent of the GPL is to control the distribution of collective works
based on the Program; not just derived works.

You _really_ should consult a lawyer and make sure the final paragraphs
of §2 are taken into full consideration.

-- 
dwmw2


