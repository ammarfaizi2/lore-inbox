Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbSLXIZv>; Tue, 24 Dec 2002 03:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267068AbSLXIZv>; Tue, 24 Dec 2002 03:25:51 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32698 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267065AbSLXIZv>;
	Tue, 24 Dec 2002 03:25:51 -0500
Date: Tue, 24 Dec 2002 14:19:51 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.52-dcl1
Message-ID: <20021224141951.A18357@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <1040426052.1078.96.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1040426052.1078.96.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Fri, Dec 20, 2002 at 11:17:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Dec 20, 2002 at 11:17:29PM +0000, Stephen Hemminger wrote:
> OSDL common:
> * linux-2.5.52-osdl1
> . More updates to LKCD                  (me)
> . Update kprobes to use notifiers       (me)

There is problem with this. In kprobe_event(), DIE_INT3 has be
handled outside the check for kprobe_running(). 
kprobe_handler() will check whether this INT3 event is due
to a kprobe.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
