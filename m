Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSGPJCd>; Tue, 16 Jul 2002 05:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSGPJCc>; Tue, 16 Jul 2002 05:02:32 -0400
Received: from holomorphy.com ([66.224.33.161]:57729 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317829AbSGPJC1>;
	Tue, 16 Jul 2002 05:02:27 -0400
Date: Tue, 16 Jul 2002 02:05:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] shrink task_struct by removing per_cpu utime and stime
Message-ID: <20020716090509.GC1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20020716070943.GL1022@holomorphy.com> <1026814352.1687.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1026814352.1687.5.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 11:12:32AM +0100, Alan Cox wrote:
> A PS: to that. I'm not opposed to removing them. I'd prefer them left
> around in the kernel debugging options though

In that case, I can make it conditional on something like
CONFIG_DEBUG_SCHED, which option of course would go in the "Kernel Hacking"
section.


Cheers,
Bill
