Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTI0Nkf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 09:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTI0Nkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 09:40:35 -0400
Received: from netcore.fi ([193.94.160.1]:10506 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S261712AbTI0Nkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 09:40:33 -0400
Date: Sat, 27 Sep 2003 16:40:26 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: "Alexey V. Yurchenko" <ayurchen@path.emicnetworks.com>
cc: Stephen Hemminger <shemminger@osdl.org>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: how to set multicast MAC ligitemately?
In-Reply-To: <20030927160445.6ff09796.ayurchen@mail.emicnetworks.com>
Message-ID: <Pine.LNX.4.44.0309271638150.13619-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003, Alexey V. Yurchenko wrote:
> On Fri, 26 Sep 2003 12:03:45 -0700
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > 
> > Not interface should have a multicast MAC address. A multicast address
> > should only exist as a destination address, never a source.
> 
> Well, that's in theory. In practice I need several computers connected
> to a switch to share a single interface and look to the rest of LAN as a
> single node. All those computers must receive all packets desitned to
> that interface. Using non-multicast MAC confuses many switches.

This likely breaks with IGMP snooping switches, btw.

> Any suggestions? (Except not using a switch ;))
> 
> PS isn't this approach (forbidding certain addresses) a tad
> Microsoftish? Like saving users from themselves?

The rules are there to prevent users from shooting themselves in the foot, 
or the users thinking using multicast MAC address as source is a right way 
to solve a problem.

But Linux is Free Software and Open Source.  You can change these things 
if you really want.

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings


