Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVAMRsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVAMRsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVAMRJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:09:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:6842 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261254AbVAMRID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:08:03 -0500
Date: Thu, 13 Jan 2005 09:07:12 -0800
From: Greg KH <greg@kroah.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, tytso@us.ibm.com,
       suparna@in.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050113170712.GA867@us.ibm.com>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050107010119.GS1292@us.ibm.com> <20050113025157.GA2849@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113025157.GA2849@us.ibm.com>
X-Operating-System: Linux 2.6.10-bk14 (i686)
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 06:51:57PM -0800, Paul E. McKenney wrote:
> 
> The current hope is that adding (a) shared and asymmetrically shared
> subtrees between namespaces/locations in the same namespace, (b) stackable
> LSM modules, and (c) dynamic recursive union mount would enable Linux
> to provide this in a technically sound manner.  [But this is not clear
> to me yet.]

I don't see how (b) has anything to do with this.  Anyone care to
explain that?

thanks,

greg k-h
