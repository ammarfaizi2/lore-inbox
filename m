Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTIHU1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTIHU1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:27:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:11687 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263583AbTIHU1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:27:02 -0400
Subject: Re: I/O degredation with AS on 2.6.0-test3
From: Dave Hansen <haveblue@us.ibm.com>
To: Mike Sullivan <mksully@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <OF0770DEDD.BEBEF8A2-ON85256D9B.00659B11@us.ibm.com>
References: <OF0770DEDD.BEBEF8A2-ON85256D9B.00659B11@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1063052763.29025.100.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Sep 2003 13:26:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might want to try Martin Bligh's diffprofile utility.  It's a bit
hard to compare 2 500-line profiles without it.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/tools/

Also, there have evidently been a few I/O scheduler fixes since -test3. 
Please retry with -test5.
-- 
Dave Hansen
haveblue@us.ibm.com

