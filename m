Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbWFIVn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbWFIVn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWFIVn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:43:57 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:26930 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030528AbWFIVnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:43:55 -0400
Date: Fri, 9 Jun 2006 14:43:31 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609214331.GL3574@ca-server1.us.oracle.com>
Mail-Followup-To: Alex Tomas <alex@clusterfs.com>,
	Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chase Venters <chase.venters@clientec.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <1149880865.22124.70.camel@localhost.localdomain> <m3irna6sja.fsf@bzzz.home.net> <4489CB42.6020709@garzik.org> <m3wtbq5dgw.fsf@bzzz.home.net> <20060609204418.GG3574@ca-server1.us.oracle.com> <m3fyie5a19.fsf@bzzz.home.net> <20060609211123.GI3574@ca-server1.us.oracle.com> <m364ja58m8.fsf@bzzz.home.net> <20060609212905.GK3574@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609212905.GK3574@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 02:29:05PM -0700, Joel Becker wrote:
> 	However, tunefs(8) and mkfs(8) is generally understood to make
> physical changes.  Why not "tunefs -extents" to turn them on?  It's
> completely analogous to "tunefs -J", will fit everyone's expectation,
> and won't surprise people.  "mkfs -extents" does the same thing.

	Heck, if you have code to convert extents back to regular ext3,
"tunefs -noextents" works and is properly symmetric.

Joel

-- 

"The nice thing about egotists is that they don't talk about other
 people."
         - Lucille S. Harper

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
