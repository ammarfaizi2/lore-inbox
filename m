Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbUBWTzX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUBWTzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:55:23 -0500
Received: from palrel12.hp.com ([156.153.255.237]:13723 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262021AbUBWTzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:55:17 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16442.23201.23710.686062@napali.hpl.hp.com>
Date: Mon, 23 Feb 2004 11:55:13 -0800
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris McDermott <lcm@us.ibm.com>,
       ia64 <linux-ia64@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] linux-2.6.3_time-interpolator-fix_A0
In-Reply-To: <1077565468.19860.78.camel@cog.beaverton.ibm.com>
References: <1077081648.985.27.camel@cog.beaverton.ibm.com>
	<1077086574.985.56.camel@cog.beaverton.ibm.com>
	<16435.3326.193311.110598@napali.hpl.hp.com>
	<1077565468.19860.78.camel@cog.beaverton.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 23 Feb 2004 11:44:29 -0800, john stultz <johnstul@us.ibm.com> said:

  John> This patch removes the incorrect call to
  John> time_interpolator_update and was found to resolve the time
  John> inconsistencies I had seen while developing the ia64-cyclone
  John> patch.

  John> Please consider for inclusion.

In case it isn't clear: this patch has my support.

	--david
