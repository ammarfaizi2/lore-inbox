Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUHCG3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUHCG3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 02:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUHCG3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 02:29:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:36844 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265086AbUHCG3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 02:29:50 -0400
Date: Tue, 3 Aug 2004 11:58:48 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patchset] Lockfree fd lookup 2 of 5
Message-ID: <20040803062847.GA1753@vitalstatistix.in.ibm.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802101604.GD4385@vitalstatistix.in.ibm.com> <20040803004343.GC26323@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803004343.GC26323@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 05:43:43PM -0700, Greg KH wrote:
> On Mon, Aug 02, 2004 at 03:46:06PM +0530, Ravikiran G Thirumalai wrote:
> > Here's the second patch.  This changes the current kref users to use
> > the 'shrunk' kref objects and api.  GregKH has applied this to his tree too.
> 
> Well, I applied this, and then fixed it to actually link and work
> properly.  Next time, please at least build your patches...
> ...

I did build it before sending it.  My initial submission to you
was based on 2.6.7 and you'd said it was applied.  My current submission
is 2.6.7 based too, and I didn't check for any driver changes since
you'd said you already applied it (although I couldn't confirm it since 
I did not know which bk tree you use).  The current patchset builds fine on
my setup on 2.6.7.  Please let me know what I missed so that I can take
care of such things in future.

Thanks,
Kiran
