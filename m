Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVIDF5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVIDF5N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 01:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVIDF5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 01:57:13 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:31225 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1751207AbVIDF5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 01:57:12 -0400
Date: Sat, 3 Sep 2005 22:56:51 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Daniel Phillips <phillips@istop.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904055650.GX8684@ca-server1.us.oracle.com>
Mail-Followup-To: Daniel Phillips <phillips@istop.com>,
	Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
	wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509040051.11095.phillips@istop.com> <20050904050026.GU8684@ca-server1.us.oracle.com> <200509040152.30027.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509040152.30027.phillips@istop.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 01:52:29AM -0400, Daniel Phillips wrote:
> You do have ->release and ->make_item/group.

	->release is like kobject release.  It's a free callback, not a
callback from close.

> If I may hand you a more substantive argument: you don't support user-driven
> creation of files in configfs, only directories.  Dlmfs supports user-created
> files.  But you know, there isn't actually a good reason not to support
> user-created files in configfs, as dlmfs demonstrates.

	It is outside the domain of configfs.  Just because it can be
done does not mean it should be.  configfs isn't a "thing to create
files".  It's an interface to creating kernel items.  The actual
filesystem representation isn't the end, it's just the means.

Joel

-- 

"In the room the women come and go
 Talking of Michaelangelo."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

