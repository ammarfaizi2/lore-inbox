Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWE1VL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWE1VL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 17:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWE1VL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 17:11:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17865 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750939AbWE1VL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 17:11:27 -0400
Subject: Re: Resume stops working between 2.6.16 and 2.6.17-rc1 on Dell
	Inspiron 6000
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Dickson <dickson@permanentmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060528140238.2c25a805.dickson@permanentmail.com>
References: <20060528140238.2c25a805.dickson@permanentmail.com>
Content-Type: text/plain
Date: Sun, 28 May 2006 23:11:23 +0200
Message-Id: <1148850683.3074.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 14:02 -0700, Paul Dickson wrote:
> I follow the Fedora development kernels and noticed that resuming from
> suspending (and hibernate) stopped working at 2.6.16-git15 (Fedora Core
> kernel 2102).  Trouble was, my only previous kernel was 2.6.16-rc6-git12
> (FC 2064) because I had been out of town for nearly two weeks (I did have
> limited net access and that's how I got that last working version).

have you verified they have both the same general .config file? Like
both are smp or both UP, same APIC settings etc etc 
That's all easy to check and those two are the most likely candidates in
config land that could break resume... 
(not saying those are the cause or have changed, no idea, but they're
really cheap to check that none have changed, much cheaper than a
bisect ;)

