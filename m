Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316686AbSGLR1x>; Fri, 12 Jul 2002 13:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSGLR1w>; Fri, 12 Jul 2002 13:27:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47860 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316686AbSGLR1v>; Fri, 12 Jul 2002 13:27:51 -0400
Subject: [PATCH] strict VM overcommit for stock 2.4
From: Robert Love <rml@tech9.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1026426511.1244.321.camel@sinai>
References: <1026426511.1244.321.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Jul 2002 10:30:39 -0700
Message-Id: <1026495039.1750.379.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A version of Alan's strict VM overcommit for the stock VM is available
for 2.4.19-rc1 at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/vm/strict-overcommit/2.4/vm-strict-overcommit-rml-2.4.19-rc1-1.patch

This is the same code I posted yesterday (see "[PATCH] strict VM
overcommit for" from 20020711) except for the stock non-rmap VM in 2.4.

Hugh Dickins sent me a few fixes, mostly for shmfs accounting, that he
recently discovered... that code is not yet merged but will be, probably
after this weekend.

I still encourage testing and comments.

	Robert Love

