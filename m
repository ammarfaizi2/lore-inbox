Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUEQXCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUEQXCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUEQXCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:02:45 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:7906 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263079AbUEQXCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:02:16 -0400
Subject: Re: [PATCH] init. mca_bus_type even if !MCA_bus
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
In-Reply-To: <20040517155222.11f4b253.akpm@osdl.org>
References: <20040517144603.1c63895f.rddunlap@osdl.org>
	<20040517151412.1f7fb7d4.akpm@osdl.org>
	<20040517150828.2d5afc1a.rddunlap@osdl.org> 
	<20040517155222.11f4b253.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 May 2004 18:02:11 -0500
Message-Id: <1084834932.1814.69.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 17:52, Andrew Morton wrote:
> well my question really was a question, rather than a reimplementation
> suggestion.  If it _is_ appropriate that mca_bus_type be registered on a
> platform which is discovered to have no MCA hardware then fine.
> 
> Greg? James?  Any insights?

If the use compiles with CONFIG_MCA it makes sense to register the bus. 
It's also certainly easier than having to check for MCA_bus being set in
all of the routines.

James


