Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUCDNSi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUCDNSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:18:38 -0500
Received: from aun.it.uu.se ([130.238.12.36]:24452 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261885AbUCDNSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:18:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16455.11425.183861.70559@alkaid.it.uu.se>
Date: Thu, 4 Mar 2004 14:18:25 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: __buggy_fxsr_alignment() not found.
In-Reply-To: <Pine.GSO.3.96.SK.1040304140003.4028A-100000@univ.uniyar.ac.ru>
References: <20040301122428.7dc96b00.rddunlap@osdl.org>
	<Pine.GSO.3.96.SK.1040304140003.4028A-100000@univ.uniyar.ac.ru>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Yu. Zhbanov writes:
 > > | I cannot compile 2.4.24 kernel because linker says:
 > > | init/main.o: In function `check_fpu':
 > > | init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
...
 > My compiler is pgcc-2.95.3 (gcc optimized for Pentium).

AFAIK, pgcc is/was notorious for not being 100% correct.
gcc-2.95.3, gcc-3.2.3, or gcc-3.3.3 should work much better.
