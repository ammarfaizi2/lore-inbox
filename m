Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267201AbTGHLL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGHLL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:11:58 -0400
Received: from holomorphy.com ([66.224.33.161]:6306 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S267201AbTGHLLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:11:47 -0400
Date: Tue, 8 Jul 2003 04:26:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Flameeyes <dgp85@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Message-ID: <20030708112644.GH15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Flameeyes <dgp85@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu> <1057647818.5489.385.camel@workshop.saharacpt.lan> <20030708072604.GF15452@holomorphy.com> <200307081051.41683.schlicht@uni-mannheim.de> <20030708085558.GG15452@holomorphy.com> <1057657046.1819.11.camel@mufasa.ds.co.ug> <20030708110122.GA10756@vana.vc.cvut.cz> <1057663430.2449.5.camel@laurelin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057663430.2449.5.camel@laurelin>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-08 at 13:01, Petr Vandrovec wrote:
>> vmware-any-any-update35.tar.gz should work on 2.5.74-mm2 too.
>> But it is not tested, I have enough troubles with 2.5.74 without mm patches...

On Tue, Jul 08, 2003 at 01:23:50PM +0200, Flameeyes wrote:
> vmnet doesn't compile:
> make: Entering directory `/tmp/vmware-config1/vmnet-only'
> In file included from userif.c:51:
> pgtbl.h: In function `PgtblVa2PageLocked':
> pgtbl.h:82: warning: implicit declaration of function `pmd_offset'
> pgtbl.h:82: warning: assignment makes pointer from integer without a
> cast
> make: Leaving directory `/tmp/vmware-config1/vmnet-only'

I've got some long-running benchmarks going at the moment on my main
dev boxen but I should be able to get a fix going soon.


-- wli
