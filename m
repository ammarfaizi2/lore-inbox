Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUE1Ubv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUE1Ubv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUE1Ubv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:31:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:56563 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261375AbUE1Ubt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:31:49 -0400
Subject: Re: oops, 2.4.26 and jfs
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <Pine.LNX.4.58.0405281307550.18184@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0405281307550.18184@potato.cts.ucla.edu>
Content-Type: text/plain
Message-Id: <1085776292.13846.18.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 28 May 2004 15:31:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 15:15, Chris Stromsoe wrote:
> This morning during a cron run while doing a find across /, I got the
> following oops.

The oops is fixed in 2.4.27-pre3 with the patch:
http://linux.bkbits.net:8080/linux-2.4/cset@1.1359.20.3

jfs still may give you problems if 0-order allocations are failing, but
it's not supposed to trap.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

