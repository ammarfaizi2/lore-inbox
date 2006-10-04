Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWJDAoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWJDAoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWJDAoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:44:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20148 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161040AbWJDAoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:44:38 -0400
Date: Tue, 3 Oct 2006 20:43:14 -0400
From: Dave Jones <davej@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: FSX on NFS blew up.
Message-ID: <20061004004314.GA21677@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
References: <20061003164905.GD23492@redhat.com> <1159922084.9569.24.camel@dyn9047017100.beaverton.ibm.com> <20061004004009.GA20459@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004004009.GA20459@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 08:40:09PM -0400, Dave Jones wrote:
 > On Tue, Oct 03, 2006 at 05:34:44PM -0700, Badari Pulavarty wrote:
 >  > On Tue, 2006-10-03 at 12:49 -0400, Dave Jones wrote:
 >  > > Took ~8hrs to hit this on an NFSv3 mount. (2.6.18+Jan Kara's jbd patch)
 >  > > 
 >  > > http://www.codemonkey.org.uk/junk/fsx-nfs.txt
 >  > 
 >  > I was seeing *similar* problem on NFS mounted filesystem (while running
 >  > fsx), but later realized that filesystem is full - when it happend.
 >  > 
 >  > Could be fsx error handling problem ? Can you check yours ?
 > 
 > It's running low, but there's no way it ran out. (It's down to about 4GB free).

I just noticed the fsxlog that got dumped in that dir contains
some slightly different info to what got dumped to stdout.

I've pasted it onto the end of the file in the URL above.

	Dave

-- 
http://www.codemonkey.org.uk
