Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSLURfc>; Sat, 21 Dec 2002 12:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSLURfc>; Sat, 21 Dec 2002 12:35:32 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26697 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262214AbSLURfb>; Sat, 21 Dec 2002 12:35:31 -0500
Date: Sat, 21 Dec 2002 12:45:54 -0500
From: Doug Ledford <dledford@redhat.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021221174554.GA9703@redhat.com>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <20021221002940.GM25000@holomorphy.com> <190380000.1040432350@aslan.btc.adaptec.com> <20021221013500.GN25000@holomorphy.com> <223910000.1040435985@aslan.btc.adaptec.com> <20021221085510.A25881@infradead.org> <4093022704.1040484612@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4093022704.1040484612@aslan.scsiguy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2002 at 08:30:12AM -0700, Justin T. Gibbs wrote:
> revision.  I just do it as a single CSET with the comments dispersed
> into the individual files that the comments apply to.

Which is perfectly acceptable IMHO.  There is no reason that a cset need 
document all the details when the file logs already do.  A cset need only 
indicate what basic work is being done and maybe a list of files in the 
cset.  Doing a bk changes -v gets the file comments as well for those 
people that want them.

I actually like the individual file comments part of the cset setup.  It's 
what my preferred use is when I'm making my own patches.  Make the cset 
have a summary of the major changes, then let each file have it's own 
detail change information.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
