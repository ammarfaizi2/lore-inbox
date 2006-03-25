Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWCYRiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWCYRiu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 12:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWCYRiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 12:38:50 -0500
Received: from main.gmane.org ([80.91.229.2]:50319 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751457AbWCYRit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 12:38:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Date: Sat, 25 Mar 2006 09:38:26 -0800
Message-ID: <8764m2v2zx.fsf@benpfaff.org>
References: <20060322011034.GP12571@goober>
	<1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com>
	<20060322224844.GU12571@goober>
	<20060322175503.3b678ab5.akpm@osdl.org>
	<20060324143239.GB14508@goober>
	<20060324192802.GK14852@schatzie.adilger.int>
	<20060324200131.GE18020@thunk.org>
	<20060324210033.GQ14852@schatzie.adilger.int>
	<20060324213905.GG18020@thunk.org>
	<20060324221656.GW14852@schatzie.adilger.int>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-23.hsd1.ca.comcast.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:7B3CSHlLPxiI0sIM+g8iINTXzXE=
Cc: ext2-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> writes:

> On Mar 24, 2006  16:39 -0500, Theodore Ts'o wrote:
>> The former: a filesystem test harness in userspace, possibly with some
>> kernel code changes to make it easier to integrate it with the
>> userspace test harness.  It's very similar to what the Netfilter folks
>> did, and it has the advantage that we can do testing much more
>> quickly, especially in cases where we want to simulate crashes at
>> certain specific test points to make sure the journal recovery happens
>> correctly.
>
> I seem to recall that the Stanford Metacompilation group (Dawson Engler)
> already wrote such a tool.  Not sure what sort of access there is for the
> tool, whether public funding would grant access to the public, or if they
> are at least willing to make an online interface available (the group has
> spun out into "Coverity", and it seems unlikely it will be completely OSS).

I know the guys who wrote FiSC, the tool in question, and I have
even hacked on related software a little bit myself.  I suspect
that, if asked, they would say that the code is rather
embarrassing and that they wouldn't want to release it for that
reason.  However, to my knowledge it wasn't written by or in
conjunction with Coverity, so there wouldn't be any issues of
that kind.

If you want to pursue this, I'd recommend emailing Paul Twohey
<twohey@CS.Stanford.EDU> or Junfeng Yang <yjf@stanford.edu>.  As
I understand it, they are the grad students who spent the most
time working on FiSC and related tools.
-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org

