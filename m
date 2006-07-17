Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWGQVvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWGQVvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWGQVvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:51:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:46750 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751208AbWGQVvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:51:07 -0400
Subject: [Patch 0/3] delay accounting fixes
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Balbir Singh <balbir@in.ibm.com>, Chris Sturtivant <csturtiv@sgi.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1153173063.4551.10.camel@dyn9002218086.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 Jul 2006 17:51:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Following are some fixes to the delay accounting & 
taskstats patches, against 2.6.18-rc2.

The most significant change is the third patch in the
series which turns on delay accounting by default. This 
is a temporary measure to ensure that the features get
coverage testing in 2.6.18-rc kernels without requiring
kernel options to be turned on. Late in the -rc
series, it can be reversed (will send a patch to do that)

--Shailabh


