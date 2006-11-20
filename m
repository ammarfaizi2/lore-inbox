Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965804AbWKTNCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965804AbWKTNCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 08:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965817AbWKTNCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 08:02:52 -0500
Received: from mail.electro-mechanical.com ([216.184.71.30]:34642 "EHLO
	mail.electro-mechanical.com") by vger.kernel.org with ESMTP
	id S965804AbWKTNCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 08:02:52 -0500
Date: Mon, 20 Nov 2006 08:02:50 -0500
From: William Thompson <wt@electro-mechanical.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Targus USB2 port replicator ethernet port on 2.6.12+
Message-ID: <20061120130250.GA23866@electro-mechanical.com>
References: <20060517120718.GN18746@electro-mechanical.com> <20061109111916.4a55a98e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109111916.4a55a98e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 11:19:16AM -0800, Andrew Morton wrote:
> If this bug is still present in 2.6.19-rc5 could you please raise a report
> at bugzilla.kernel.org?

I just tested it, it appears to be working now.  Both obtaining a DHCP lease
and pinging work.  I see the following from the kernel:

[232666.744627] l1: set allmulti
[232666.745361] l1: set allmulti
[232666.790816] l1: set allmulti
[232666.806160] l1: set allmulti
[232666.806990] l1: set allmulti
[232666.807157] l1: set allmulti
[232667.809358] l1: set allmulti

l1 is the name of the interface.
