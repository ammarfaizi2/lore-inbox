Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752151AbWFWWju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbWFWWju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbWFWWju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:39:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2520 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752148AbWFWWjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:39:49 -0400
Date: Fri, 23 Jun 2006 18:39:26 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux SCSI Mailing list <linux-scsi@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, mike.miller@hp.com
Subject: Re: [RFC] [PATCH 1/2] introduce crashboot kernel command line parameter
Message-ID: <20060623223926.GD18384@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060623210121.GA18384@in.ibm.com> <E1FttEj-0002JH-00@calista.eckenfels.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FttEj-0002JH-00@calista.eckenfels.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 11:30:45PM +0200, Bernd Eckenfels wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > +static int __init set_crash_boot(char *str)
> > +{
> > +       crash_boot = 1;
> > +       return 1;
> > +}
> 
> what about a printk? Maybe a combined one which shows some other stuff (init
> level, init shell, apic settings) etc from command line.
> 

In your response, all the people copied on the mail got removed. I am adding
them back.

May be a printk. Not very sure. User can always see in the console messages
list of command line options passed to the kernel.

apic settings are displayed if you pass apic=debug.

Not very sure what do you mean by displaying init level, and init shell
and how that stuff is related to this parameter. 

Thanks
Vivek
