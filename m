Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272736AbRIGPyL>; Fri, 7 Sep 2001 11:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272733AbRIGPyB>; Fri, 7 Sep 2001 11:54:01 -0400
Received: from ns.caldera.de ([212.34.180.1]:41427 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S272736AbRIGPxs>;
	Fri, 7 Sep 2001 11:53:48 -0400
Date: Fri, 7 Sep 2001 17:53:24 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Peter Wong <wpeter@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Hans Tannenberger <Hans-Joachim.Tannenberger@us.ibm.com>,
        Ruth Forester <rsf@us.ibm.com>, lahr <lahr@us.ibm.com>,
        "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: Re: [Lse-tech] Re: Lockmeter Analysis of 2 DDs
Message-ID: <20010907175324.A19821@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, Peter Wong <wpeter@us.ibm.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
	Hans Tannenberger <Hans-Joachim.Tannenberger@us.ibm.com>,
	Ruth Forester <rsf@us.ibm.com>, lahr <lahr@us.ibm.com>,
	"Carbonari, Steven" <steven.carbonari@intel.com>
In-Reply-To: <OFBC292301.DC08DA17-ON85256AC0.00555C52@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFBC292301.DC08DA17-ON85256AC0.00555C52@raleigh.ibm.com>; from wpeter@us.ibm.com on Fri, Sep 07, 2001 at 10:47:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 10:47:37AM -0500, Peter Wong wrote:
>      Indeed, io_request_lock is very hot once the bounce buffers were
> eliminated. Is anyone working on a patch for the io_request_lock that
> possibly take the global lock and splits it into a per device queue lock?
> We understand that getting this patch into 2.4 is unlikely, but it would
> be nice to have this patch available on 2.4 for experimental purposes.

ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/v2.5/

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
