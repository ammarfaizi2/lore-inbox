Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWJCUwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWJCUwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 16:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWJCUwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 16:52:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:47849 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030385AbWJCUwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 16:52:43 -0400
Date: Tue, 3 Oct 2006 15:52:40 -0500
To: akpm@osdl.org, jeff@garzik.org
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/4]: Spidernet transmit patches
Message-ID: <20061003205240.GE4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following set of four patches provide some more spidernet fixes.
Most important are a pair of patches to stop the transmit queue when it
is full, and to actually turn off transmit interrupts during NAPI(!)

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>


