Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbUAFQ2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUAFQ2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:28:36 -0500
Received: from lists.us.dell.com ([143.166.224.162]:28038 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264455AbUAFQ2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:28:32 -0500
Date: Tue, 6 Jan 2004 10:28:19 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jan Kokoska <kokoska.jan@globe.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre4
Message-ID: <20040106102819.A12626@lists.us.dell.com>
References: <Pine.LNX.4.58L.0401061159090.1207@logos.cnet> <1073405784.880.410.camel@marigold>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1073405784.880.410.camel@marigold>; from kokoska.jan@globe.cz on Tue, Jan 06, 2004 at 05:16:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trying to compile $subj with following config (these options seem to
> cause the problem, full config attached):
> 
> CONFIG_SCSI_MEGARAID=y
> CONFIG_SCSI_MEGARAID2=y
>
> Is this a known issue and megaraids can't live together, or am I
> supposed to be able to compile both drivers in and this is a bug?

yes, this is known and expected.  You can build both as modules, but
they're not intended to both be loaded simultaneously (either built-in
or as modules).  They're mutually exclusive.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
