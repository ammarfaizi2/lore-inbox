Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVIDBek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVIDBek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 21:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVIDBek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 21:34:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750752AbVIDBej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 21:34:39 -0400
Date: Sat, 3 Sep 2005 18:32:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050903183241.1acca6c9.akpm@osdl.org>
In-Reply-To: <20050904010912.GJ8684@ca-server1.us.oracle.com>
References: <20050901104620.GA22482@redhat.com>
	<200509030242.36506.phillips@istop.com>
	<20050903064633.GB4593@ca-server1.us.oracle.com>
	<200509031821.27070.phillips@istop.com>
	<20050904010912.GJ8684@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> On Sat, Sep 03, 2005 at 06:21:26PM -0400, Daniel Phillips wrote:
>  > that fit the configfs-nee-sysfs model?  If it does, the payoff will be about 
>  > 500 lines saved.
> 
>  	I'm still awaiting your merge of ext3 and reiserfs, because you
>  can save probably 500 lines having a filesystem that can create reiser
>  and ext3 files at the same time.

oy.   Daniel is asking a legitimate question.

If there's duplicated code in there then we should seek to either make the
code multi-purpose or place the common or reusable parts into a library
somewhere.

If neither approach is applicable or practical for *every single function*
then fine, please explain why.  AFAIR that has not been done.
