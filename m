Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268675AbTCCWlE>; Mon, 3 Mar 2003 17:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268685AbTCCWlE>; Mon, 3 Mar 2003 17:41:04 -0500
Received: from holomorphy.com ([66.224.33.161]:2454 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268675AbTCCWlE>;
	Mon, 3 Mar 2003 17:41:04 -0500
Date: Mon, 3 Mar 2003 14:51:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <20030303225115.GP1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20030302202451.GJ1195@holomorphy.com> <50380000.1046637959@[10.10.2.4]> <20030302210606.GS24172@holomorphy.com> <85980000.1046642338@[10.10.2.4]> <20030302221037.GK1195@holomorphy.com> <87420000.1046646801@[10.10.2.4]> <20030302234252.GL1195@holomorphy.com> <88060000.1046650020@[10.10.2.4]> <20030303014320.GM1195@holomorphy.com> <29220000.1046713200@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29220000.1046713200@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 09:40:01AM -0800, Martin J. Bligh wrote:
> OK, that seems to get rid of the SDET degradation, but I rigged up the
> same test you were doing (make -j) and see only marginal improvement
> from the full patch (pernode2) ... not the 6s you were seeing.
> -pernode2 was your full patch with the fix you sent, -pernode3 was the 
> smaller patch you sent last. Can you try to reproduce the improvment
> were seeing, and grab a before and after profile? I don't seem to be 
> able to replicate it.

Then there must have been something important in the new per_cpu users.


-- wli
