Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264974AbUFGSG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUFGSG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 14:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUFGSG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 14:06:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21758 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264974AbUFGSGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 14:06:47 -0400
Date: Mon, 7 Jun 2004 23:32:51 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, axboe@suse.de, lmb@suse.de, kevcorry@us.ibm.com,
       arjanv@redhat.com, iro@parcelfarce.linux.theplanet.co.uk,
       trond.myklebust@fys.uio.no, lustre-devel@clusterfs.com
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
Message-ID: <20040607180251.GA6416@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040602231554.ADC7B3100AE@moraine.clusterfs.com> <20040604165548.GC20820@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604165548.GC20820@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2004 at 02:55:48AM +1000, Anton Blanchard wrote:
>  
> > 10. "Have these patches undergone any siginifant test?" by Anton Blanchard:
> >  
> > There are two important questions I think: 
> > - Do the patches cause damage?
> >    Probably not anymore. SUSE has done testing and it appears the
> >    original patch I attached didn't break things (after one fix was
> >    made).
> 
> IBM did a lot of the work on that issue and it took the better part of a 
> week to find, fix and verify.

AFAIK, Maneesh asked about revalidate_special() returning negative dentries
and no checking of it in path lookup(), but got no reply from Lustre
folks. It is clearly broken. Maneesh has more breakage from Lustre
VFS patches now. It would be helpful if they atleast comment on
fixes for those.

Thanks
Dipankar
