Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUGJK6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUGJK6L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 06:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUGJK6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 06:58:10 -0400
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:5508 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S266209AbUGJK6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 06:58:08 -0400
Subject: rss recovery
From: FabF <fabian.frederick@skynet.be>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <40EFC076.9050504@yahoo.com.au>
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>
	 <cone.1089268800.781084.4554.502@pc.kolivas.org>
	 <20040708001027.7fed0bc4.akpm@osdl.org>
	 <cone.1089273505.418287.4554.502@pc.kolivas.org>
	 <20040708010842.2064a706.akpm@osdl.org>
	 <cone.1089275229.304355.4554.502@pc.kolivas.org>
	 <1089284097.3691.52.camel@localhost.localdomain>
	 <40EDEF68.2020503@kolivas.org>
	 <1089366486.3322.10.camel@localhost.localdomain>
	 <40EE76CC.5070905@yahoo.com.au>
	 <1089371646.3322.38.camel@localhost.localdomain>
	 <40EE8075.6060700@yahoo.com.au>
	 <1089452697.3646.11.camel@localhost.localdomain>
	 <40EFC076.9050504@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1089457076.3646.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 10 Jul 2004 12:57:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,
	Putting some more pressure I finally saw the awaited behaviour from np
: rss gaining 1MB (or at least 1 byte :) : top reports 10M -> 11M )
directly after make was done with 10 threads.

But I guess it can do much better than that (IOW recover original rss).
Where does re-attribution takes place in np ?

Regards,
FabF

