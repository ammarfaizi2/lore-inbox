Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbUABHpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 02:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUABHpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 02:45:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:40581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265367AbUABHpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 02:45:53 -0500
Date: Thu, 1 Jan 2004 23:46:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] aiodio_fallback_bio_count.patch
Message-Id: <20040101234634.53b69a3b.akpm@osdl.org>
In-Reply-To: <20040102051422.GB3311@in.ibm.com>
References: <20031231015913.34fc0176.akpm@osdl.org>
	<20031231100949.GA4099@in.ibm.com>
	<20031231021042.5975de04.akpm@osdl.org>
	<20031231104801.GB4099@in.ibm.com>
	<20031231025309.6bc8ca20.akpm@osdl.org>
	<20031231025410.699a3317.akpm@osdl.org>
	<20031231031736.0416808f.akpm@osdl.org>
	<1072910061.712.67.camel@ibm-c.pdx.osdl.net>
	<1072910475.712.74.camel@ibm-c.pdx.osdl.net>
	<20031231154648.2af81331.akpm@osdl.org>
	<20040102051422.GB3311@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
>  Does the following sound better as complete description ?

It does, thanks.  But it does not shed a lot of light on the filemap.c
changes - what's going on there?

What is the significance of `written > count' in there, and of `dio->result
> dio->size' in finished_one_bio()?  How can these states come about?

