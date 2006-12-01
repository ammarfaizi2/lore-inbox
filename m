Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934293AbWLAHuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934293AbWLAHuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935687AbWLAHuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:50:25 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:62051 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP id S934293AbWLAHuY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:50:24 -0500
Subject: Re: [PATCH] UBI: take 2
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, haver@vnet.ibm.com,
       arnez@vnet.ibm.com, llinux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1164947098.19697.45.camel@crusty.rchland.ibm.com>
References: <1164824246.576.65.camel@sauron>
	 <20061130170624.94fde80d.akpm@osdl.org>
	 <1164947098.19697.45.camel@crusty.rchland.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 01 Dec 2006 09:49:49 +0200
Message-Id: <1164959389.576.78.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 01 Dec 2006 07:49:47.0265 (UTC) FILETIME=[45CD0F10:01C7151D]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Andrew,

On Thu, 2006-11-30 at 22:24 -0600, Josh Boyer wrote:
> On Thu, 2006-11-30 at 17:06 -0800, Andrew Morton wrote:
> >  		err = ubi_eba_write_leb(ubi, vol_id, lnum, tbuf, off, len,
> > -					UBI_DATA_UNKNOWN, &written, 0, NULL);
> > +					UBI_DATA_UNKNOWN, &written, NULL);
> Nice catch.  Odd that gcc doesn't throw a warning on my system with it
> being like that.

Because this piece of code is for debugging purposes only and it is
usually disabled. You probably haven't ever enabled it.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)

