Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268284AbTAMFiR>; Mon, 13 Jan 2003 00:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268282AbTAMFiR>; Mon, 13 Jan 2003 00:38:17 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:7185 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S268284AbTAMFiO>; Mon, 13 Jan 2003 00:38:14 -0500
Date: Mon, 13 Jan 2003 05:46:59 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: Brian Tinsley <btinsley@emageon.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: qla2300 driver stability, (was Re: 2.4.20, .text.lock.swap cpu
 usage?)
In-Reply-To: <3E22356F.2000205@emageon.com>
Message-ID: <Pine.LNX.4.44.0301130541530.26185-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Brian Tinsley wrote:

> The 6.01.00-fo driver from QLogic.

hmm..

> problem. I've had this driver running in my lab and at numerous client 
> sites for quite some time and have never seen it even burp.

how hard did you push it in testing?

in some configurations i've had to subject it to many hours of
intensive IO (ie multiple concurrent and continious bonnie++ runs of
varying file sizes) in order to get it to spin in
qla2x00_intr_handler. but it will eventually hang given enough IO ime.  
(in other configurations, heavy sustained IO will lock it up in
minutes, even seconds).

> Interesting. Again, I've never seen this behavior, but I appreciate
> your mentioning it. It's definitely something to keep an eye out
> for.

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

