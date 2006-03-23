Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWCWJmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWCWJmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWCWJmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:42:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18056 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751448AbWCWJmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:42:24 -0500
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, ian.pratt@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <a15cee148267ad7406a077c28c0c97ac@cl.cam.ac.uk>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
	 <1143101972.3147.11.camel@laptopd505.fenrus.org>
	 <a15cee148267ad7406a077c28c0c97ac@cl.cam.ac.uk>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 10:42:14 +0100
Message-Id: <1143106935.3147.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If we stick to just our own major then we break distro init scripts and 
> surprise users.

btw init scripts don't really break because of this, at least sane ones
don't. It's installers that may need a few tweaks, but those are minor
at worst.


