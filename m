Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424454AbWKKA0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424454AbWKKA0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 19:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424459AbWKKA0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 19:26:51 -0500
Received: from gw.goop.org ([64.81.55.164]:8647 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1424454AbWKKA0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 19:26:50 -0500
Message-ID: <455518C6.8000905@goop.org>
Date: Fri, 10 Nov 2006 16:26:46 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: magnus.damm@gmail.com, horms@verge.net.au, ebiederm@xmission.com,
       magnus@valinux.co.jp, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com,
       ak@muc.de, fastboot@lists.osdl.org, anderson@redhat.com
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
References: <20061110005051.GB4107@verge.net.au>	<aec7e5c30611092000k397fb578xc59a990043fc310a@mail.gmail.com>	<45550D2F.2070004@goop.org> <20061110.153930.23011358.davem@davemloft.net>
In-Reply-To: <20061110.153930.23011358.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> I think Elf64 notes very much would need 64-bit alignment, especially
> if there are u64 objects in there.  Otherwise it would not be possible
> to directly dereference such objects without taking unaligned faults
> on several types of RISC cpus.
>   

That doesn't appear to have been a problem.

    J

