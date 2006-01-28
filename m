Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWA1MXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWA1MXi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 07:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWA1MXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 07:23:38 -0500
Received: from darwin.snarc.org ([81.56.210.228]:25297 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1751307AbWA1MXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 07:23:38 -0500
Date: Sat, 28 Jan 2006 13:23:35 +0100
From: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
To: Greg KH <greg@kroah.com>
Cc: "Mike D. Day" <ncmike@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
Message-ID: <20060128122335.GA24382@snarc.org>
References: <43DAD4DB.4090708@us.ibm.com> <20060128023828.GA20881@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128023828.GA20881@kroah.com>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 06:38:28PM -0800, Greg KH wrote:
> > +
> > +int __init
> > +hyper_sysfs_init(void)
> > +{
> > +	int err ;
> > +	
> > +	if( 0 ==  (err = subsystem_register(&hypervisor_subsys)) ) {
> > +		xen_kset.subsys = &hypervisor_subsys;
> > +		err = kset_register(&xen_kset);
> > +	}
> 
> Is this the xen coding style?  If so, it's got to change before making
> it into mainline...  Please fix this up.

No, this is not coding style we use for linux related files.
The patch really need to be fix ...

-- 
Vincent Hanquez
