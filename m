Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVADCUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVADCUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 21:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVADCUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 21:20:49 -0500
Received: from holomorphy.com ([207.189.100.168]:42881 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261965AbVADCUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 21:20:45 -0500
Date: Mon, 3 Jan 2005 18:20:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: colin@coesta.com, linux-kernel@vger.kernel.org
Subject: Re: Max CPUs on x86_64 under 2.6.x
Message-ID: <20050104022034.GB2708@holomorphy.com>
References: <44438.202.154.120.74.1104760841.squirrel@www.coesta.com> <m14qhyxc9h.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14qhyxc9h.fsf@muc.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Colin Coe" <colin@coesta.com> writes:
>> Why is the number of CPUs on the x86_64 architecture only 8 but under i386
>> it is 255?
>> I've searched the list archives and Google but can't find an answer.

On Tue, Jan 04, 2005 at 01:34:50AM +0100, Andi Kleen wrote:
> Post 2.6.10 x86-64 will support more CPUs. 2.6.10 actually does too,
> but the Kconfig hadn't been changed then. Previously there was an
> 8 CPU APIC driver limit, however it turned out later that it doesn't
> apply to some Opteron machines.

Barring cpus with a different onboard interrupt controller from the
xAPIC or the use of external interrupt controllers to assist with cpu
addressing, 255 serves as an architectural limit for Opteron as well.


-- wli
