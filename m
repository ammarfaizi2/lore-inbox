Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUGADov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUGADov (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUGADov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:44:51 -0400
Received: from lakermmtao05.cox.net ([68.230.240.34]:19380 "EHLO
	lakermmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263818AbUGADot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:44:49 -0400
In-Reply-To: <20040701032606.GA1564@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Testing PROT_NONE and other protections, and a surprise
Date: Wed, 30 Jun 2004 23:44:48 -0400
To: Jamie Lokier <jamie@shareable.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 30, 2004, at 23:26, Jamie Lokier wrote:
### i386 ###
> Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
> ======================================================================= 
> =
> MAP_SHARED     | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx
> MAP_PRIVATE    | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx

### ppc32 ### Appears to be the same
Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
========================================================================
MAP_SHARED     | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx
MAP_PRIVATE    | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx

Just for kicks, I ran this on Mac OS X too :-D  Interesting results!
Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
========================================================================
MAP_SHARED     | ---    r-x    ---    rwx    ---    r-x    ---    rwx
MAP_PRIVATE    | ---    r-x    ---    rwx    ---    r-x    ---    rwx

Cheers,
Kyle Moffett


