Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbTDRWJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 18:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTDRWJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 18:09:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13553 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263265AbTDRWJV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 18:09:21 -0400
Date: Fri, 18 Apr 2003 15:21:32 -0700
From: Greg KH <greg@kroah.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] /sbin/hotplug multiplexor - take 2
Message-ID: <20030418222132.GB8703@kroah.com>
References: <A46BBDB345A7D5118EC90002A5072C780BEBB10B@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBB10B@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 05:01:40PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> > From: Greg KH [mailto:greg@kroah.com]
> >
> > ...
> >
> > for I in "${DIR}/$1/"* "${DIR}/"all/* ; do
> > 	test -x $I && $I $1 ;
> 
> test -x "$I" && "$I" "$1"
> 
> Just in case?

Good idea, I've changed it.

thanks,

greg k-h
