Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269495AbUINWDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269495AbUINWDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUINWA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:00:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:16311 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269584AbUINRJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:09:32 -0400
Date: Tue, 14 Sep 2004 10:08:56 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: paulmck@us.ibm.com
Cc: ak@suse.de, dipankar@in.ibm.com, maneesh@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Add rcu_assign_pointer() to kill more memory
 barriers
Message-Id: <20040914100856.528bd6c9@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040907223037.GA13346@us.ibm.com>
References: <20040907223037.GA13346@us.ibm.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, memory barriers are the second major source of confusion
for many developers (after locking).
