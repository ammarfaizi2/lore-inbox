Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWG1JYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWG1JYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 05:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWG1JYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 05:24:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21437 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161113AbWG1JYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 05:24:11 -0400
Subject: Re: The ondemand CPUFreq code -- I hope the functionality stays
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060728024334.GA12142@phoenix>
References: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com>
	 <200607272104.24088.diablod3@gmail.com>  <20060728024334.GA12142@phoenix>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 28 Jul 2006 11:24:04 +0200
Message-Id: <1154078644.3117.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Personally, I prefer conservative, because it isn't as "jumpy", but I
> can see ondemand being necessary in a server environment where the
> several second lag time to peak performance would hurt response time
> when load is low.


jumpy is fine though; at least on the processors my employer makes
changing frequency is really really fast, so you get maximum savings by
switching often (you can switch down more aggressively if you know
you'll switch back up quickly). So switching often is a good policy if
you want both good response AND good power savings... 
I don't know about other cpu makers; my frequency switching machines are
all Intel.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

