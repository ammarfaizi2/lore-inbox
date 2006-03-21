Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWCUTMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWCUTMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWCUTMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:12:06 -0500
Received: from citi.umich.edu ([141.211.133.111]:26031 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S965051AbWCUTMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:12:05 -0500
Message-ID: <44205003.8070702@citi.umich.edu>
Date: Tue, 21 Mar 2006 14:12:03 -0500
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Network Appliance, Inc.
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
Subject: Re: [NFS] [GIT] NFS client update for 2.6.16
References: <1142961077.7987.14.camel@lade.trondhjem.org>	 <20060321174634.GA15827@infradead.org>	 <1142964532.7987.61.camel@lade.trondhjem.org>	 <20060321185734.GB19125@infradead.org> <1142967981.7987.92.camel@lade.trondhjem.org>
In-Reply-To: <1142967981.7987.92.camel@lade.trondhjem.org>
Content-Type: multipart/mixed;
 boundary="------------020505010409050904040303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020505010409050904040303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Trond Myklebust wrote:
> As I said in my other posting, I believe Chuck's changes are relatively
> orthogonal to what you want to do: they neither make the low-level
> plumbing better or worse for readv()/writev().
> 
> We'd be happy to work with you in the run-up to 2.6.18 to add
> multi-segment support for the existing patchsets. It makes more sense to
> me to append that functionality to the existing patchsets rather than
> trigger a complete rewrite (and thus have a sh_tload more code to
> retest).

after i reviewed this work with zach last summer, he and i also agreed 
that it would be best if i did this work after the generic changes are 
integrated -- so he wouldn't have to work on, and possibly break, the 
NFS client.

i have been watching the multi-segment iovec work since then, and fully 
intended to add the support for readv/writev aio in the NFS direct path 
when the generic support becomes available.

--------------020505010409050904040303
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Open Source NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://troy.citi.umich.edu/u/cel/
version:2.1
end:vcard


--------------020505010409050904040303--
