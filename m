Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVFHMRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVFHMRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVFHMRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:17:41 -0400
Received: from gate.in-addr.de ([212.8.193.158]:5557 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262189AbVFHMRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:17:35 -0400
Date: Wed, 8 Jun 2005 14:13:04 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] [2.6.12-rc6-mm1] Handle READA requests in dm-mpath.c
Message-ID: <20050608121304.GU27119@marowsky-bree.de>
References: <20050608110436.GQ27119@marowsky-bree.de> <20050608043347.5db85317.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050608043347.5db85317.akpm@osdl.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-06-08T04:33:47, Andrew Morton <akpm@osdl.org> wrote:

> Lars Marowsky-Bree <lmb@suse.de> wrote:
> >
> > READA errors failing with EWOULDBLOCK/EAGAIN do not constitute a valid
> > reason for failing the path; this lead to erratic errors on DM multipath
> > devices. This error can be safely propagated upwards without failing the
> > path.
> > 
> 
> Why do you describe this as a -mm patch?  We want this in 2.6.12, no?

Uhm, right. I just diff'ed it against -mm out of habit, I guess, because
I also assumed you were the fastest path to Linus ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

