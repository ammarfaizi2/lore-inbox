Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136776AbREIRgR>; Wed, 9 May 2001 13:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136775AbREIRgH>; Wed, 9 May 2001 13:36:07 -0400
Received: from ns.caldera.de ([212.34.180.1]:64915 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S136776AbREIRf4>;
	Wed, 9 May 2001 13:35:56 -0400
Date: Wed, 9 May 2001 19:35:21 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: "Andrew M. Theurer" <atheurer@austin.ibm.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@samba.org>
Subject: Re: [Lse-tech] Re: Linux 2.4 Scalability, Samba, and Netbench
Message-ID: <20010509193521.A25108@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	"Andrew M. Theurer" <atheurer@austin.ibm.com>,
	Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	samba-technical <samba-technical@samba.org>
In-Reply-To: <3AF97062.42465A53@austin.ibm.com> <20010509095658.B1150@w-mikek2.sequent.com> <3AF97EBB.9F0ABE9A@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF97EBB.9F0ABE9A@austin.ibm.com>; from atheurer@austin.ibm.com on Wed, May 09, 2001 at 12:30:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 12:30:35PM -0500, Andrew M. Theurer wrote:
> I do have kernprof ACG and lockmeter for a 4P run.  We saw no
> significant problems with lockmeter.  csum_partial_copy_generic was the
> highest % in profile, at 4.34%.  I'll see if we can get some space on
> http://lse.sourceforge.net to post the test data.

Maybe you should try Kernel 2.4.4 (with Zerocopy TCP/IP) and Anton's
sendfile for samba patch.  A copy of the latter was posted to lkml - see
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0484.html,
even if that maybe be unusable to due html crappieness.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
