Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWCFPqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWCFPqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWCFPqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:46:04 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:18849
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751749AbWCFPqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:46:03 -0500
Date: Mon, 6 Mar 2006 07:46:04 -0800
From: Greg KH <greg@kroah.com>
To: Ben Chelf <ben@coverity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coverity Open Source Defect Scan of Linux
Message-ID: <20060306154604.GA7355@kroah.com>
References: <440BCA0F.50501@coverity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440BCA0F.50501@coverity.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 09:35:11PM -0800, Ben Chelf wrote:
>   Right now, we're guarding access to the actual defects that we report 
> for a couple of reasons: (1) We think that you, as developers of Linux, 
> should have the chance to look at the defects we find to patch them 
> before random other folks get to see what we found and (2) From a 
> support perspective, we want to make sure that we have the appropriate 
> time to engage with those who want to use the results to fix the code. 

If you feel these are security related, please contact
security@kernel.org with the information (as is documented in the kernel
documentation).  If you do not feel they are security related, but just
normal bugs that don't really cause problems, feel free to just post the
information here on lkml, and cc: the maintainers of the affected areas
of code.

In other words, these should be treated like any other potential bug
report.  And I mean "potential", as your tool has had false positives in
the past :)

thanks,

greg k-h
