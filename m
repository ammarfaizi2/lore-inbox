Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272418AbRIGRKX>; Fri, 7 Sep 2001 13:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272782AbRIGRKG>; Fri, 7 Sep 2001 13:10:06 -0400
Received: from e24.nc.us.ibm.com ([32.97.136.230]:45250 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272418AbRIGRJr>; Fri, 7 Sep 2001 13:09:47 -0400
Date: Fri, 7 Sep 2001 10:04:56 -0700
From: lahr <lahr@us.ibm.com>
To: Peter Wong <wpeter@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Hans Tannenberger <Hans-Joachim.Tannenberger@us.ibm.com>,
        Ruth Forester <rsf@us.ibm.com>,
        "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: Re: Lockmeter Analysis of 2 DDs
Message-ID: <20010907100456.A11427@us.ibm.com>
In-Reply-To: <OFBC292301.DC08DA17-ON85256AC0.00555C52@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFBC292301.DC08DA17-ON85256AC0.00555C52@raleigh.ibm.com>; from wpeter@us.ibm.com on Fri, Sep 07, 2001 at 10:47:37AM -0500
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>      Indeed, io_request_lock is very hot once the bounce buffers were
> eliminated. Is anyone working on a patch for the io_request_lock that
> possibly take the global lock and splits it into a per device queue lock?
> We understand that getting this patch into 2.4 is unlikely, but it would
> be nice to have this patch available on 2.4 for experimental purposes.

I recently published a patch for 2.4 that addresses this exact issue at
http://lse.sourceforge.net/io/

Jonathan

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

