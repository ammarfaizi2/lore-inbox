Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVGVTyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVGVTyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 15:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVGVTyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 15:54:20 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:47852 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262150AbVGVTyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 15:54:14 -0400
Date: Fri, 22 Jul 2005 12:53:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: mbligh@mbligh.org, matthltc@us.ibm.com, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, gh@us.ibm.com
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
Message-Id: <20050722125335.10b3ee0b.pj@sgi.com>
In-Reply-To: <42E070F9.6010009@watson.ibm.com>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050715150034.GA6192@infradead.org>
	<20050715131610.25c25c15.akpm@osdl.org>
	<20050717082000.349b391f.pj@sgi.com>
	<1121985448.5242.90.camel@stark>
	<20050721163227.661a5169.pj@sgi.com>
	<42E03DD2.6020308@mbligh.org>
	<20050721204631.1fb4d9a5.pj@sgi.com>
	<42E070F9.6010009@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh wrote:
> So if the current CPU controller 
>   implementation is considered too intrusive/unacceptable, it can be 
> reworked or (and we certainly hope not) even rejected in perpetuity. 

It is certainly reasonable that you would hope such.

But this hypothetical possibility concerns me a little.  Where would
that leave CKRM, if it was in the mainline kernel, but there was no CPU
controller in the mainline kernel?  Wouldn't that be a rather serious
problem for many users of CKRM if they wanted to work on mainline
kernels?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
