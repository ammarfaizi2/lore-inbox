Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290098AbSA3QmU>; Wed, 30 Jan 2002 11:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290078AbSA3Qk5>; Wed, 30 Jan 2002 11:40:57 -0500
Received: from ns.suse.de ([213.95.15.193]:517 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289989AbSA3QkM>;
	Wed, 30 Jan 2002 11:40:12 -0500
Date: Wed, 30 Jan 2002 17:40:11 +0100
From: Dave Jones <davej@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: =?iso-8859-1?Q?Sebastian_Dr=F6ge?= <sebastian.droege@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020130174011.L24012@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Oleg Drokin <green@namesys.com>,
	=?iso-8859-1?Q?Sebastian_Dr=F6ge?= <sebastian.droege@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de> <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130190905.A820@namesys.com>; from green@namesys.com on Wed, Jan 30, 2002 at 07:09:05PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 07:09:05PM +0300, Oleg Drokin wrote:

 > I can reproduce this problem on IDE only.
 > Hm, may be this is IDE corruption thing, Andre Hendrick spoke about,
 > or was it fixed already?
 > I am looking into it anyway.

 There were no IDE changes in my tree recently, and its strange
 that this only shows up in reiserfs since the new set of patches
 went in. I've no reports from users of other filesystems with any
 problems, so I'm suspecting a rogue change in your last update.

 Finding a common factor seems tricky, as it works flawlessly here
 on IDE [*], but dies instantly for others.


 [*] Even with stress tools.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
