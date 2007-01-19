Return-Path: <linux-kernel-owner+w=401wt.eu-S1751392AbXASQ5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbXASQ5b (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 11:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbXASQ5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 11:57:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60073 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbXASQ5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 11:57:30 -0500
Subject: Re: unable to mmap /dev/kmem
From: Arjan van de Ven <arjan@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nadia Derbey <Nadia.Derbey@bull.net>, Franck Bui-Huu <fbuihuu@gmail.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0701191539070.4009@blonde.wat.veritas.com>
References: <45AFA490.5000508@bull.net>
	 <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
	 <45B08B17.3060807@bull.net>
	 <Pine.LNX.4.64.0701191539070.4009@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 19 Jan 2007 17:57:04 +0100
Message-Id: <1169225824.3055.507.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-19 at 16:33 +0000, Hugh Dickins wrote:
> Though I do wonder whether
> it was safe to change its behaviour at that stage: more evidence that
> few have actually been using mmap of /dev/kmem. 

... and maybe we should just kill /dev/kmem entirely... it seems mostly
used by rootkits but very few other things, if any at all...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

