Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUATJ0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbUATJ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:26:48 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:54737 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265303AbUATJ0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:26:39 -0500
Date: Tue, 20 Jan 2004 14:59:38 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, lhcs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040120145938.A24847@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040120063316.GA9736@hockin.org> <20040120082232.ED1282C2ED@lists.samba.org> <20040120083700.GB15733@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040120083700.GB15733@hockin.org>; from thockin@hockin.org on Tue, Jan 20, 2004 at 12:37:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 12:37:01AM -0800, Tim Hockin wrote:
> If a CPU gets yanked with no warning, where do we
> run the signal handler?  Violating affinity again.

With the current CPU Hotplug design, I don't think this is allowed.
A CPU has to be offlined first in software before it is yanked out
from hardware.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
