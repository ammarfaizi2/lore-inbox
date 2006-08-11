Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWHKRDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWHKRDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 13:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWHKRDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 13:03:44 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:34785 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750779AbWHKRDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 13:03:43 -0400
Date: Fri, 11 Aug 2006 12:03:37 -0500
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Cc: James K Lewis <jklewis@us.ibm.com>, Utz Bacher <utz.bacher@de.ibm.com>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/4]:  powerpc/cell spidernet ethernet driver fixes
Message-ID: <20060811170337.GH10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following series of patches implement some fixes and performance
improvements for the Spedernet ethernet device driver. The high point
of the patch series is some code to implement a low-watermark interrupt
on the transmit queue. The bundle of patches raises transmit performance 
from some embarassingly low value to a reasonable 730 Megabits per
second for 1500 byte packets.

Please note that the spider is an ethernet controller that is 
integrated into the south bridge, and is thus available only on
Cell-based platforms.

These have been well-tested over the last few weeks. Please apply. 

--linas
