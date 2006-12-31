Return-Path: <linux-kernel-owner+w=401wt.eu-S933101AbWLaJ1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933101AbWLaJ1e (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 04:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933103AbWLaJ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 04:27:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57646 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933101AbWLaJ1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 04:27:33 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: Arjan van de Ven <arjan@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, torvalds@osdl.org, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20061231092318.GA1702@flint.arm.linux.org.uk>
References: <20061230165012.GB12622@flint.arm.linux.org.uk>
	 <Pine.LNX.4.64.0612301022200.4473@woody.osdl.org>
	 <20061230224604.GA3350@flint.arm.linux.org.uk>
	 <20061230.212338.92583434.davem@davemloft.net>
	 <20061231092318.GA1702@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 31 Dec 2006 10:27:22 +0100
Message-Id: <1167557242.20929.647.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> However, it's not only FUSE which is suffering - direct-IO also doesn't
> work. 

for direct-IO the kernel won't touch the data *at all*... (that's the
point ;) 

is it still an issue then?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

