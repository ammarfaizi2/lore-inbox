Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUDKPLy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 11:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUDKPLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 11:11:54 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:46023 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261500AbUDKPLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 11:11:53 -0400
Date: Sun, 11 Apr 2004 08:11:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduler problems on shutdown
Message-ID: <1860000.1081696302@[10.10.2.4]>
In-Reply-To: <40791475.7040300@cyberone.com.au>
References: <1516092704.1081534916@[10.10.2.4]> <71390000.1081611090@[10.10.2.4]> <40791475.7040300@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the WARN_ON can go. You have to make sure the for_each_cpu
> loop doesn't get to run it though. It shouldn't be in the latest -mm
> kernels, is it?

OK, I'll figure it out. I don't like the latest code, so don't really want
to "upgrade" though.
 
> It is normal to have an entire group offline with CPU hotplug.

Only if we can't figure out how to hotplug groups as well, which would
be a much cleaner way of doing it.

M.

