Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVLHODl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVLHODl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVLHODl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:03:41 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:60327 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932117AbVLHODk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:03:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=tp1S4iBq1d5yY4V/Yy9qALcHp+jkD/LWMlQJGQQtxW0Pw6HLpXkexQc6cx4YZDQxNAuCGZVW9ssxk7IVZN8qROpO8fOnPxyj6QWKVubvE/esoRemMyzufg6U1KEhlKxnimSfdS68aRBrqVCpH6GZJYtX2u/8WAk8RR00fGZA0mw=
Date: Thu, 8 Dec 2005 15:03:16 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Dirk Steuwer <dirk@steuwer.de>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Linux in a binary world... a doomsday scenario
Message-Id: <20051208150316.26838909.diegocg@gmail.com>
In-Reply-To: <loom.20051208T140839-587@post.gmane.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	<20051205121851.GC2838@holomorphy.com>
	<20051206011844.GO28539@opteron.random>
	<1133857767.2858.25.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.63.0512071337560.17172@cuia.boston.redhat.com>
	<Pine.LNX.4.58.0512071041420.17648@shark.he.net>
	<1133981708.2869.54.camel@laptopd505.fenrus.org>
	<20051207201612.GV28539@opteron.random>
	<1133986742.2869.65.camel@laptopd505.fenrus.org>
	<20051207204029.GW28539@opteron.random>
	<loom.20051208T140839-587@post.gmane.org>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 8 Dec 2005 13:23:11 +0000 (UTC),
Dirk Steuwer <dirk@steuwer.de> escribió:


> For a hardwaredatabase i like to see a structure. Kernel developers are 
> required to enter the support into the database, when submitting the driver.
> Ongoing status will be logged there as well. Status and devices can only be 
> entered by kernel developers.

[Please don't remove the CC list]

This sounds like the typical nightmare that never is 100% accurate and
needs lots of mainteinance (developers not updating the wiki, etc) as
Lee Revell pointed out.

IMO the one way of creating such database is automating it. If you
could get a list of the device IDs supported by drivers you 
could (?) use the pciid/usbid/whatever list to build a user-readable
database of the devices supported by the linux tree. Maybe it won't
100% perfect but...
