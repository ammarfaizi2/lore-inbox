Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTJTOak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTJTOaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:30:39 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:40928 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262572AbTJTOai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:30:38 -0400
Date: Mon, 20 Oct 2003 07:27:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <764430000.1066660038@[10.10.2.4]>
In-Reply-To: <20031019113248.17eb0a5c.akpm@osdl.org>
References: <20031015225055.GS17986@fs.tum.de><20031015161251.7de440ab.akpm@osdl.org><20031015232440.GU17986@fs.tum.de><20031015165205.0cc40606.akpm@osdl.org><20031018102127.GE12423@fs.tum.de><649730000.1066491920@[10.10.2.4]><20031018102402.3576af6c.akpm@osdl.org><20031018174434.GJ12423@fs.tum.de><20031018105733.380ea8d2.akpm@osdl.org><668910000.1066578207@[10.10.2.4]> <20031019113248.17eb0a5c.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>>  > It would take a quite a lot of work to measure this properly.  A simple A/B
>>  > comparison doesn't cut it.
>> 
>>  So why are we changing it then? ;-)
> 
> It is very easy to demonstrate that it saves 300 kilobytes of memory.

OK, fair enough - so can we either do:

1) a config option

or 

2) if you hate that, at least switch it to -O2 on CONFIG_SMP, on the grounds
that such systems generally have larger caches, and plenty of RAM.

M.

