Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbTA1HXR>; Tue, 28 Jan 2003 02:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTA1HXQ>; Tue, 28 Jan 2003 02:23:16 -0500
Received: from holomorphy.com ([66.224.33.161]:34984 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267329AbTA1HXP>;
	Tue, 28 Jan 2003 02:23:15 -0500
Date: Mon, 27 Jan 2003 23:31:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: kexec reboot code buffer
Message-ID: <20030128073117.GJ780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org> <3E35AAE4.10204@us.ibm.com> <m1r8ax69ho.fsf@frodo.biederman.org> <20030128071826.GI780@holomorphy.com> <m1isw968e3.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1isw968e3.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:
>> Seriously, just plop down the fresh zone type and all will be well.
>> It's really incredibly easy.

On Tue, Jan 28, 2003 at 12:28:04AM -0700, Eric W. Biederman wrote:
> I will certainly take a look, tracing through that code can get a little
> hairy.

It can really be approached much more cavalierly than that. The only
extant example aside from the original ZONE_DMA32 implementation I've
seen is Simon Winwood's MPSS patch, which needed something on the order
of 10 lines of code for a fresh zone type (for one arch).

And most of the bulk of the ZONE_DMA32 implementation was stringing up
the block layer to utilize it, not inserting the new zone type itself.


-- wli
