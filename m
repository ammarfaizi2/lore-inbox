Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422874AbWBASzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422874AbWBASzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbWBASzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:55:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12239 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422874AbWBASzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:55:45 -0500
Subject: Re: [patch -mm4] i386: __init should be __cpuinit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Andrew Morton <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
In-Reply-To: <20060201160324.GA5875@redhat.com>
References: <200601312352_MC3-1-B748-FCE9@compuserve.com>
	 <200601312352_MC3-1-B748-FCE9@compuserve.com>
	 <20060201053357.GA5335@redhat.com>
	 <E1F4Czv-00018m-00@chiark.greenend.org.uk>
	 <20060201160324.GA5875@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Feb 2006 18:56:22 +0000
Message-Id: <1138820183.3943.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-01 at 11:03 -0500, Dave Jones wrote:
>  > For SMP systems, suspend/resume "unplugs" all non-boot CPUs before
>  > executing the suspend code. I don't recall any SMP cyrix systems, but
>  > it's potentially something to consider.
> 
> There weren't any.  Until AMD's Athlon MPs, Intel had the only
> SMP x86 afair.

Several vendors demonstrated OpenMP designs including Cyrix. Nothing
production and nothing we support.

