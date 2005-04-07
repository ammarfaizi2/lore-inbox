Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVDGVYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVDGVYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 17:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVDGVXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 17:23:09 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:24746 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262609AbVDGVWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 17:22:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GnWhDUQlowJqxh5vaZ3EntcgZD5iLnxaZCNOLTb4SsreE8AGcePDPSrxnmWb/tBXL2kxPJO0M/qXwftik43ZarXujoUhO9piT7h7AxZOlvQG0rzZ1qiDDORNo21qxgWLjcIRAyTf8PoKuDPAN1hda6oNG8SE0u6mgU1YevBP4oA=
Message-ID: <21d7e9970504071422349426eb@mail.gmail.com>
Date: Fri, 8 Apr 2005 07:22:09 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL accesses
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <jehdii8hjk.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <1110519743.5810.13.camel@gaston> <1110672745.5787.60.camel@gaston>
	 <je8y3wyk3g.fsf@sykes.suse.de> <1112743901.9568.67.camel@gaston>
	 <jeoecr1qk8.fsf@sykes.suse.de> <1112827655.9518.194.camel@gaston>
	 <jehdii8hjk.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are 1694 calls to radeon_pll_errata_after_data during a switch from
> X to the console and 393 calls the other way.

Wow... Ben that seems a bit extreme... there's not even close to 393 plls :-)

Dave.
