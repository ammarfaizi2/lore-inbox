Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUENQ7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUENQ7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUENQ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:59:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261746AbUENQ71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:59:27 -0400
Message-ID: <40A4FADD.3000202@pobox.com>
Date: Fri, 14 May 2004 12:59:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, Robert.Picco@hp.com,
       linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
References: <40A3F805.5090804@hp.com> <40A40204.1060509@pobox.com> <20040513164226.7efb2a83.akpm@osdl.org> <40A40982.60202@pobox.com> <20040514111926.GA30876@ucw.cz>
In-Reply-To: <20040514111926.GA30876@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, May 13, 2004 at 07:49:22PM -0400, Jeff Garzik wrote:
>>HPET writes into RAM at magic addresses, so it's not really a bus address.
> 
> 
> Since it lives in the bridge (either north or south), IMO it is a bus
> address ... at least on AMD machines it's the same space where MMIO
> comes from.

hmmm, yeah, you're right.  I stand corrected.

	Jeff



