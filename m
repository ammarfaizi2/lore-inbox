Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUBEVyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUBEVyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:54:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:58566 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266896AbUBEVyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:54:05 -0500
Date: Thu, 5 Feb 2004 13:54:01 -0800
From: Greg KH <greg@kroah.com>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: "King, Steven R" <steven.r.king@intel.com>, linux-kernel@vger.kernel.org,
       infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Message-ID: <20040205215401.GE15718@kroah.com>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C3682@orsmsx410.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C3682@orsmsx410.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 12:16:17PM -0800, Woodruff, Robert J wrote:
> I think that we tried to isolate a lot of these kernel calls into
> one library, the component library, so that when the kernel APIs change,
> which seems to happen every release, we only have to change the code 
> in one spot. 

Then get your code into the kernel tree, and you will not have to worry
about this "problem".  Remember, that is what we are talking about here.
If you want to keep your "compatibility" library in your out-of-tree
code, that's fine with me, I don't care.

It's when you try to push that into the main kernel tree that I start to
care.

> Are there any other examples of drivers that isolate kernel specific
> calls to one module or file of their code to ease portability between
> different revisions of the kernel ? If not, maybe they should look at
> what we have done, it might save them some headaches in the future. 

No, that is not how Linux kernel development is done.  Come on people,
do your research...

greg k-h
