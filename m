Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbTFFGh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 02:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265358AbTFFGh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 02:37:28 -0400
Received: from holomorphy.com ([66.224.33.161]:51901 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265352AbTFFGh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 02:37:27 -0400
Date: Thu, 5 Jun 2003 23:50:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arvind Kandhare <arvind.kan@wipro.com>
Cc: manfred <manfred@colorfullife.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@digeo.com,
       "indou.takao" <indou.takao@jp.fujitsu.com>, Dave Jones <davej@suse.de>
Subject: Re: [RFC][PATCH 2.5.70] Static tunable semvmx and semaem
Message-ID: <20030606065023.GB8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arvind Kandhare <arvind.kan@wipro.com>,
	manfred <manfred@colorfullife.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, akpm@digeo.com,
	"indou.takao" <indou.takao@jp.fujitsu.com>,
	Dave Jones <davej@suse.de>
References: <3EE02C53.1040800@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE02C53.1040800@wipro.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 11:23:23AM +0530, Arvind Kandhare wrote:
> Hi,
> Please find below patch(RFC) for implementing semvmx and semaem
> as static tunable parameters.
> These can be modified at boot time using command line interface.
> Please comment/suggest.

Your MUA ate the whitespace in the patch.

Also, I'm not convinced it's useful to pollute init/main.c here.
Something under /proc/sys/kernel/ with the other shm bits should do.

I might look deeper into whether the audit for signedness and other
size issues is complete once those are dealt with.


-- wli
