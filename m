Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSLTLH4>; Fri, 20 Dec 2002 06:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSLTLH4>; Fri, 20 Dec 2002 06:07:56 -0500
Received: from holomorphy.com ([66.224.33.161]:38341 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261409AbSLTLHy>;
	Fri, 20 Dec 2002 06:07:54 -0500
Date: Fri, 20 Dec 2002 03:15:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, bjorn_helgaas@hp.com
Subject: Re: [PATCH] Fix CPU bitmask truncation
Message-ID: <20021220111523.GA7644@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	bjorn_helgaas@hp.com
References: <200212161213.29230.bjorn_helgaas@hp.com> <20021220103028.GB9704@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220103028.GB9704@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:13:29PM -0700, Bjorn Helgaas wrote:
>> This patch fixes some obviously incorrect bitmask truncations in 2.4.20.

On Fri, Dec 20, 2002 at 02:30:28AM -0800, William Lee Irwin III wrote:
> Linus, this is the 2.5.x version of the same patch originally by Bjorn
> for 2.4.x. This fixes an entire class of critical 64-bit bugs.
> Against 2.5.52-bk as of 2:25AM 20 Dec 2002. Please apply.

Actually, this looks like a non-issue from userspace on the IA64 boxen
I can get to. akpm pointed out that this seemed to pass his testing,
and on deeper inspection, IA64 userspace did not find this to be an issue.

Bjorn, could you explain on what toolchains and/or architectures you had
this issue? It sounds serious and/or real enough yet I can't actually
make this happen myself.


Thanks,
Bill
