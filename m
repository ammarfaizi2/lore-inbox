Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWB1SY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWB1SY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWB1SY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:24:56 -0500
Received: from zrtps0kn.nortelnetworks.com ([47.140.192.55]:35211 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP id S932213AbWB1SY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:24:56 -0500
Message-ID: <44049559.80109@nortel.com>
Date: Tue, 28 Feb 2006 12:24:25 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: "Bryan O'Sullivan" <bos@pathscale.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
References: <1140841250.2587.33.camel@localhost.localdomain> <yq08xrvhkee.fsf@jaguar.mkp.net> <1141149475.24103.18.camel@camp4.serpentine.com> <Pine.LNX.4.61.0602281302080.4698@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602281302080.4698@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2006 18:24:27.0903 (UTC) FILETIME=[359E48F0:01C63C94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

> Also, the
> PCI bus is a FIFO. Nothing gets reordered.

The CPU itself can reorder the write before it hits the PCI bus.  I 
don't think x86 will do this, but others will.

Chris
