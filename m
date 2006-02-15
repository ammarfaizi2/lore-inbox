Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945993AbWBOQre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945993AbWBOQre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946017AbWBOQre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:47:34 -0500
Received: from jose.lug.udel.edu ([128.175.60.112]:16035 "EHLO
	jose.lug.udel.edu") by vger.kernel.org with ESMTP id S1945993AbWBOQrd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:47:33 -0500
Date: Wed, 15 Feb 2006 11:47:33 -0500
To: Marc Koschewski <marc@osknowledge.org>
Cc: Christian <christiand59@web.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060215164732.GA29573@lug.udel.edu>
References: <20060214135016.GC10701@stusta.de> <200602141659.40176.christiand59@web.de> <20060214164002.GC5905@stiffy.osknowledge.org> <20060214184708.GA29656@lug.udel.edu> <20060215133523.GA6628@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215133523.GA6628@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11
From: ross@jose.lug.udel.edu (Ross Vandegrift)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 02:35:23PM +0100, Marc Koschewski wrote:
> I moved to CIFS because SMB didn't work well for me, as well as did NFS. Both
> seems to stall in a way, I could never really reproduce. But CIFS is very stable
> over here. Never ever had a problem with it, whereas both NFS and SMB are likely
> to cause trouble at least once a week. Without log records, without any chance
> of recovery. Mostly hard-freezes.

Well, any interaction with Windows 2k3 has to use CIFS.  SMB doesn't
work - I know, I tried smbfs first.  Of course smbclient can't really trigger
a hard lockup since it's in userspace.  I try to use it for any large
uploads I have to do, since the issue seems exclusive to the cifs
code.

NFS on the other hand, I'm not sure what issues you've seen.  I
haven't had a reproducable problem with NFS in probably ten years.
Well, at least that was Linux's fault.  I'd love it if Juniper could
explain why their VPNs are currently eating my fragmented UDP packets,
but I digress...

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
