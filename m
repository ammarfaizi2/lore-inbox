Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWAIJvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWAIJvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWAIJvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:51:37 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:61800 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751222AbWAIJvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:51:36 -0500
Date: Mon, 9 Jan 2006 01:51:08 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, mark.fasheh@oracle.com
Subject: Re: [PATCH]: How to be a kernel driver maintainer
Message-ID: <20060109095108.GH18439@ca-server1.us.oracle.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Ben Collins <ben.collins@ubuntu.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, mark.fasheh@oracle.com
References: <1136736455.24378.3.camel@grayson> <1136737997.2955.10.camel@laptopd505.fenrus.org> <1136744870.1043.4.camel@grayson> <1136745838.2955.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136745838.2955.17.camel@laptopd505.fenrus.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 07:43:58PM +0100, Arjan van de Ven wrote:
> >  Alsa, etc. All changes go someplace else before being
> > pushed to the primary kernel tree. 99% of the time, patches are going
> > somewhere else before going into the main kernel. 
> 
> that's different... that's a patch queue. That's not the same as being
> the prime repository.

	As a data point, ocfs2 is dropping its subversion repository and
moving to exactly this model -- ocfs2 development is a set of patches
pending for mainline, with mainline as the prime repository.  Really,
there's no other way to do it.  Otherwise, you get way out of sync.

Joel

-- 

"The suffering man ought really to consume his own smoke; there is no 
 good in emitting smoke till you have made it into fire."
			- thomas carlyle

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

