Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267089AbUBRWpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267098AbUBRWpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:45:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:31698 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267089AbUBRWpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:45:44 -0500
Date: Wed, 18 Feb 2004 14:45:32 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux TCP implementation
Message-Id: <20040218144532.1da036f0@dell_ss3.pdx.osdl.net>
In-Reply-To: <000f01c3f653$28a3d590$0e25fe96@pysiak>
References: <000f01c3f653$28a3d590$0e25fe96@pysiak>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 20:12:31 +0100
"Maciej Soltysiak" <solt@dns.toxicfilms.tv> wrote:

> > And are there any plans to incorporate it in the future?
> 
> There was an aproach to get vegas into 2.6.
> http://lwn.net/Articles/53133/
> 
> http://developer.osdl.org/shemminger/netx/2.6/2.6.0-test7/2.6.0-test7-netx2/
> 
> I do not know the status of this.
> I remember this patch on lkml but do not remember any feedback regarding
> it.

The patch originated from Dave Miller.  It probably won't apply now because of
the recent TCP westwood addition (it is on my fix list).  But there was something
wrong the patch, and it never managed the expanded congestion window properly.
