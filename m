Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTLXCw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 21:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTLXCw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 21:52:27 -0500
Received: from stinkfoot.org ([65.75.25.34]:18098 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S263580AbTLXCw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 21:52:26 -0500
Message-ID: <3FE8573B.2020209@stinkfoot.org>
Date: Tue, 23 Dec 2003 09:54:51 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org
Subject: Re: minor e1000 bug
References: <Pine.LNX.4.44.0312231618590.28409-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0312231618590.28409-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:
> On Mon, 22 Dec 2003, Ethan Weinstein wrote:
> 
> 
>>It'd be fantastic if we could get this implememted. I'm very pleased
>>with the quality of this driver save for this one small issue.  I'd be
>>glad to help test code if necessary as I have multiple systems using
>>e1000's, and several are testboxes.  It'd be nice to have some
>>semi-realtime stats from these cards.
> 
 >
> Ok, this is against 2.6.0, so you'll need to hand adjust it for other 
> kernels.  Let me know if you see any issues.
> 
> -scott


Much thanks. That seems to do it, tested lightly so far with two 
onboards (asus p4c800e, and supermicro X5DPL-IGM-0) using both kernels 
2.6.0 and 2.4.23, e1000-5.2.22, stats updates are much faster and seem 
more accurate. Will test with some PCI-X cards in the office tommorow, 
where I can really do some pounding.


-Ethan
