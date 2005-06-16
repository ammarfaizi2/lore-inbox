Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVFPJVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVFPJVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 05:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVFPJVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 05:21:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62175 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261225AbVFPJVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 05:21:24 -0400
Date: Thu, 16 Jun 2005 14:48:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Hareesh Nagarajan <hareesh@google.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Porting kref to a 2.4 kernel (2.4.20 or greater)
Message-ID: <20050616091853.GA4965@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <42B06344.4040909@google.com> <20050615220734.GC620@kroah.com> <42B0B017.60001@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B0B017.60001@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 03:47:51PM -0700, Hareesh Nagarajan wrote:
> Correction:
> (Appears with a *)
> 
> Greg KH wrote:
> >On Wed, Jun 15, 2005 at 10:20:04AM -0700, Hareesh Nagarajan wrote:
> >
> >>What stumbling blocks do you think I would encounter if I wanted to port 
> >>kref to a 2.4.xx kernel? Is kref tightly coupled with the kernel object 
> >>infrastructure found in the 2.6.xx kernel?
> >
> >Have you looked at the kref code to see if there is any such coupling?
> 
> >Can you describe any problems you are having doing the uncoupling?
> 
> I'm having problems porting the KObject* and Work Queue infrastructure 
> to the 2.4 kernel. Any ideas if anyone has tried this port?
> 
> (Correction: * => I meant KThread)

There were a number of backports of 2.6 workqueue stuff without
kthread (before they were introduced for cpu hotplug) floating
around in mailing list. You can probably google for them.
Aren't they sufficient or does google want to do CPU hotplug ? :)

Thanks
Dipankar
