Return-Path: <linux-kernel-owner+w=401wt.eu-S932970AbWL0Pi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970AbWL0Pi7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbWL0Pi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:38:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48673 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932960AbWL0Pi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:38:58 -0500
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and
	2.6.x kernels
From: Arjan van de Ven <arjan@infradead.org>
To: Gleb Natapov <glebn@voltaire.com>
Cc: knobi@knobisoft.de, linux-kernel@vger.kernel.org
In-Reply-To: <20061227152240.GC10953@minantech.com>
References: <927934.92732.qm@web32603.mail.mud.yahoo.com>
	 <1167232380.3281.3938.camel@laptopd505.fenrus.org>
	 <20061227152240.GC10953@minantech.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 27 Dec 2006 16:38:55 +0100
Message-Id: <1167233935.3281.3955.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If I run two threads that are doing only calculations and very little or no
> IO at all on the same socket will modern HT and dual core be the same
> (or close) performance wise?

it depends on how cache/memory bandwidth sensitive your calculation
is.... if your calculation is memory bandwidth sensitive then they're
the same. If your calculation is very sensitive to have the dataset fit
in cache.. it's another different ballgame again, because then it
depends if the cores in your dual core share the cache or not.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

