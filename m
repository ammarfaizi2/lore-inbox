Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWHJR33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWHJR33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWHJR32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:29:28 -0400
Received: from hera.kernel.org ([140.211.167.34]:40407 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1422635AbWHJR3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:29:21 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Network compatibility and performance
Date: Thu, 10 Aug 2006 10:28:41 -0700
Organization: OSDL
Message-ID: <20060810102841.55efa78a@localhost.localdomain>
References: <Pine.LNX.4.61.0608101131530.4239@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1155230922 25888 10.8.0.54 (10 Aug 2006 17:28:42 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 10 Aug 2006 17:28:42 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 11:34:23 -0400
"linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:

> 
> Hello,
> 
> Network throughput is seriously defective with linux-2.6.16.24
> if the length given to 'write()' is a large number.
> 
> Given this code on a connected socket........

What protocol (TCP?) and what Ethernet hardware (does it support TSO)?
Did you set non-blocking?
