Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTCEUsh>; Wed, 5 Mar 2003 15:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTCEUsh>; Wed, 5 Mar 2003 15:48:37 -0500
Received: from holomorphy.com ([66.224.33.161]:22687 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262500AbTCEUsg>;
	Wed, 5 Mar 2003 15:48:36 -0500
Date: Wed, 5 Mar 2003 12:58:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: High Mem Options
Message-ID: <20030305205849.GU1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gerrit Huizenga <gh@us.ibm.com>,
	"Reed, Timothy A" <timothy.a.reed@lmco.com>,
	"Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
References: <20030305122654.GR1195@holomorphy.com> <E18qfXc-0002sX-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18qfXc-0002sX-00@w-gerrit2>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Mar 2003 04:26:54 PST, William Lee Irwin III wrote:
>> Yes, the additional level of pagetables slows things down quite a bit.

On Wed, Mar 05, 2003 at 12:31:03PM -0800, Gerrit Huizenga wrote:
> Bill, do you hvae measures for this?  I seem to remember PTX's impact
> of PAE36 as being about 3-5% depending on workload.  Janet did one test
> sometime back with DB2 that showed a net of no difference on TPC-H (PAE
> slows things down, less memory pressure speeds things up) but Badari
> just repeated with 2.5.62 or 2.5.63 and saw a larger degradation.
> I'm wondering if some hardware is not getting correctly configured at
> boot with with respect to MTRR's, perhaps...  I really wouldn't expect
> a 10% impact from PAE and I don't have any consistent Linux measurements
> to validate or invalidate that much impact.

Unfortunately the number of ca. 10% I got from you. I think badari's
done some $BENCHMARK_THAT_CANNOT_BE_NAMED things recently that were
consistent with the handwavy estimate but AIUI they were not intended
to measure the effect etc. etc.


-- wli
