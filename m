Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162041AbWKOX21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162041AbWKOX21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162048AbWKOX21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:28:27 -0500
Received: from mail.devicescape.com ([207.138.119.2]:37044 "EHLO
	mail.devicescape.com") by vger.kernel.org with ESMTP
	id S1162041AbWKOX20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:28:26 -0500
Date: Wed, 15 Nov 2006 15:28:16 -0800
From: David Kimdon <david.kimdon@devicescape.com>
To: Pavel Roskin <proski@gnu.org>
Cc: "John W. Linville" <linville@tuxdriver.com>, lwn@lwn.net,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Michael Buesch <mb@bu3sch.de>, madwifi-devel@lists.sourceforge.net
Subject: Re: [Madwifi-devel] ANNOUNCE: SFLC helps developers assessar5k	(enabling free Atheros HAL)
Message-ID: <20061115232816.GA20849@devicescape.com>
References: <20061115192054.GA10009@tuxdriver.com> <1163619541.19111.6.camel@dv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163619541.19111.6.camel@dv>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 02:39:01PM -0500, Pavel Roskin wrote:
> On Wed, 2006-11-15 at 14:21 -0500, John W. Linville wrote:
> > On Wed, Nov 15, 2006 at 07:42:14PM +0100, Michael Buesch wrote:
> 
> I said it before, and it's worth repeating.  Dissolving HAL in the
> sources is easy.  It's just a matter of moving functions around without
> serious chances of breaking anything as long as the source compiles.
> The whole "HAL-based architecture" can be reshuffled and eliminated by
> one person in a few days.
> 
> Making things work properly takes years.  That's what MadWifi has been
> working on for a long time, using contributions and bug reports from
> scores of users and developers.
> 
> Rejecting MadWifi because it's HAL based is like throwing away a diamond
> ring because it's too narrow.

I completely agree.  The approach we are taking with dadwifi[1] is to
use much of the existing code from madwifi and port it to the d80211
stack.  Today dadwifi works in monitor, sta and ap mode.

-David


[1] http://madwifi.org/wiki/DadWifi

> 
> -- 
> Regards,
> Pavel Roskin
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Madwifi-devel mailing list
> Madwifi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/madwifi-devel
