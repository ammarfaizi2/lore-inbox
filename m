Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbUATQ1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 11:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUATQ1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 11:27:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265553AbUATQ1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 11:27:37 -0500
Subject: Re: filesystem bug?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: tsuchiya@labs.fujitsu.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <400CE873.3000204@labs.fujitsu.com>
References: <4007537F.4070609@labs.fujitsu.com>
	 <1074256175.4006.24.camel@sisko.scot.redhat.com>
	 <400B8CD4.8000503@labs.fujitsu.com>
	 <1074517928.3694.22.camel@sisko.scot.redhat.com>
	 <400CE873.3000204@labs.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1074616047.4195.17.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Jan 2004 16:27:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2004-01-20 at 08:36, Tsuchiya Yoshihiro wrote:

> >http://linux.bkbits.net:8080/linux-2.4/patch@1.1136.67.1

> 2. some time, i_nlink was 0 and i_dtime was set which is I think
> somewhat related with this patch, but the other time,
> part of a inode block was cleaned with 0, which I do not understand
> how at all.

Yep.  I'd really need to see exactly which kernel versions these
specific problems reproduce on to take this much further, though.  I'll
be travelling for the next week and a half, but I'll look for more
results once I'm back from that.

Thanks,
 Stephen

