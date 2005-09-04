Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVIDJjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVIDJjs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 05:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVIDJjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 05:39:48 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:29927 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1751239AbVIDJjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 05:39:47 -0400
Date: Sun, 4 Sep 2005 02:39:10 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: phillips@istop.com, linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904093910.GA8684@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
	linux-cluster@redhat.com, wim.coekaerts@oracle.com,
	linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <200509040240.08467.phillips@istop.com> <20050904002828.3d26f64c.akpm@osdl.org> <20050904080102.GY8684@ca-server1.us.oracle.com> <20050904011805.68df8dde.akpm@osdl.org> <20050904091118.GZ8684@ca-server1.us.oracle.com> <20050904021836.4d4560a5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904021836.4d4560a5.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 02:18:36AM -0700, Andrew Morton wrote:
> 	take-and-drop-lock -d domainxxx -l lock1 -e "do stuff"

	Ahh, but then you have to have lots of scripts somewhere in
path, or do massive inline scripts.  especially if you want to take
another lock in there somewhere.
	It's doable, but it's nowhere near as easy. :-)

Joel

-- 

"I always thought the hardest questions were those I could not answer.
 Now I know they are the ones I can never ask."
			- Charlie Watkins

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

