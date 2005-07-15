Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVGOTO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVGOTO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVGOTO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:14:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31164 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261156AbVGOTO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:14:56 -0400
Date: Fri, 15 Jul 2005 20:16:53 +0100
From: Joel Becker <jlbec@evilplan.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Tejun Heo <htejun@gmail.com>, Daniel McNeil <daniel@osdl.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
Message-ID: <20050715191653.GI16877@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Badari Pulavarty <pbadari@us.ibm.com>, Tejun Heo <htejun@gmail.com>,
	Daniel McNeil <daniel@osdl.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net> <42D70318.1000304@gmail.com> <42D74724.8000703@us.ibm.com> <20050715165616.GH16877@parcelfarce.linux.theplanet.co.uk> <1121449846.6755.91.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121449846.6755.91.camel@dyn9047017102.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 10:50:46AM -0700, Badari Pulavarty wrote:
> I believe some OSs do buffered IO, if there is a problem with alignment.

	That's what I said.  They all do buffered I/O if the alignment
is not 512B.  They do _not_ try to accept alignments that are smaller.
There's no good reason to.  It just adds needless complexity.

Joel

-- 

"I think it would be a good idea."  
        - Mahatma Ghandi, when asked what he thought of Western
          civilization

			http://www.jlbec.org/
			jlbec@evilplan.org
