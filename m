Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbTEaG22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbTEaG22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:28:28 -0400
Received: from holomorphy.com ([66.224.33.161]:34195 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264157AbTEaG21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:28:27 -0400
Date: Fri, 30 May 2003 23:41:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: alexander.riesen@synopsys.COM, scrosby@cs.rice.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
Message-ID: <20030531064138.GJ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, alexander.riesen@synopsys.COM,
	scrosby@cs.rice.edu, linux-kernel@vger.kernel.org
References: <20030530085901.GB11885@Synopsys.COM> <20030530.020040.52897577.davem@redhat.com> <20030531063040.GI8978@holomorphy.com> <20030530.233353.28798744.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530.233353.28798744.davem@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 30 May 2003 23:30:40 -0700
>    If the strength reduction situation changes to being properly handled
>    by gcc for most/all 64-bit arches, include/linux/hash.h can lose a #ifdef.

On Fri, May 30, 2003 at 11:33:53PM -0700, David S. Miller wrote:
> It's not a strength reduction issue, it's about not setting the
> multiply cost properly in the machine description.

If it's literally that trivial I'll put digging around the machine
descriptions on my TODO list.


-- wli
