Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbUANLU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 06:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUANLU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 06:20:28 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:27156 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S265461AbUANLU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 06:20:27 -0500
Date: Wed, 14 Jan 2004 12:20:25 +0100
From: Haakon Riiser <hakonrk@ulrik.uio.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-ID: <20040114112025.GA298@s.chello.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040113210923.GA955@s.chello.no> <20040113135152.3ed26b85.akpm@osdl.org> <20040113232624.GA302@s.chello.no> <20040113234611.GA558@s.chello.no> <Pine.LNX.4.58.0401141123460.25000@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401141123460.25000@denise.shiny.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Giuliano Pochini]

> On Wed, 14 Jan 2004, Haakon Riiser wrote:
>> For example, another problem I encountered while
>> upgrading to 2.6 was that disk intensive jobs, such as updating
>> the slocate database, made ascpu report 100% CPU usage.  I just
>> ran top (procps 2.0.16) beside it, and it reported approximately
>> 10% CPU usage, which is no more than 2.4 used.
> 
> It makes sense, since HZ is 10 times higher in 2.6. Did you
> recompile ascpu ? Check if ascpu assumes HZ is 100. In that
> case it may overstimate the cpu time by a factor 10.

No, I never thought of recompiling it, since top seems to work fine
with the same binaries.  But thanks for the tip; I'll certainly try
it and see if it works!

-- 
 Haakon
